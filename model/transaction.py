from odoo import api, models, fields, exceptions, _
import datetime
# from datetime import datetime
from odoo.exceptions import ValidationError
class CashFlow(models.Model):
   _inherit = 'account.move'

   master_id = fields.Many2one('hrsystem.transaction', required=True,copy=False)

class transaction_master(models.Model):
    _name = 'hrsystem.transaction'
    _description = 'hr system transaction'
    
    _rec_name = 'month'
    _order = 'month ASC'

    # month = fields.Date(string="الشهر")
    # year = fields.Date(string="السنة")
    state= fields.Selection([('complete','العملية مكتملة'),('in_complete','قيد المعالجة')],readonly=True) 
    transaction_details_ids = fields.One2many(
        'hrsystem.transactiondetails', 'transaction_id')


    @api.model
    def get_month_selection(self):
        months = [(str(i), datetime.date(1900, i, 1).strftime('%B')) for i in range(1, 13)]
        return months
       
       
    month = fields.Selection(selection='get_month_selection', string='الشهر', required=True)

    @api.model
    def get_year_selection(self):
        current_year = datetime.datetime.now().year
        years = [(str(i), str(i)) for i in range(current_year - 10, current_year + 1)]
        return years

    year = fields.Selection(selection='get_year_selection', string='السنة',required=True)
    
    def convirm(self):
        isExist_invoices = self.env['account.move'].search([('master_id', '=', self.id)])
        if isExist_invoices :
                raise ValidationError ("تم الإعتماد سابقا") 
            
        empolyees = self.env['hr.employee'].search([('emplo_checkbox', '=', 'True')])

        for item in self.transaction_details_ids:
            employee_details = self.env['hrsystem.details'].create({
                'net_salary': item.net_salary,
                'rewards': item.rewards,
                'discount': item.discount,
                'mounth': item.month,
                'year': item.year,
                'off_days': item.off_days,
                'loan': item.loan,
                'emp_master_id': item.empolyee_id.id
            })
            
        for recorde in empolyees:
         
            invoice_details = []
            get_employee_detail = self.env['hrsystem.transactiondetails'].search([('id', '=', item.id)])
            product_salary = self.env['product.product'].search([('products_select', '=', 'prod_salary')])
            product_salary_object = {
                'product_id': product_salary.id,
                'quantity': 1,
                'price_unit': recorde.total_salary

            }
       
            invoice_details.append((0, 0, product_salary_object))
            
            product_loan = self.env['product.product'].search([('products_select', '=', 'prod_on_account')])
            product_loan_object = {
                'product_id': product_loan.id,
                'quantity': 1,
                'price_unit': get_employee_detail.loan

            }
         
        
            invoice_details.append((0, 0, product_loan_object))
          
            product_rewards = self.env['product.product'].search([('products_select', '=', 'prod_reward')])
            product_rewards_object = {
                'product_id': product_rewards.id,
                'quantity': 1,
                'price_unit': get_employee_detail.rewards

            }
     
            invoice_details.append((0, 0, product_rewards_object))
            
            product_off_days = self.env['product.product'].search([('products_select', '=', 'prod_off_days')])
            product_off_days_object = {
                'product_id': product_off_days.id,
                'quantity': 1,
                'price_unit': get_employee_detail.discount

            }
            invoice_details.append((0, 0, product_off_days_object))
           
            jurnal_value = self.env['account.journal'].search([('type', '=', 'purchase')])
  
            invoice = self.env['account.move'].create({
                'move_type': 'in_invoice',
                'partner_id': recorde.partner_id.id,
                'invoice_date':datetime.datetime.now(),
                'journal_id': jurnal_value.id,
                'invoice_line_ids': invoice_details,
                'master_id': self.id
            })
       
            invoice.action_post()
    
        self.write({'state': 'complete'})
        print('=====state=======',self.state)
        message = {
            'type': 'ir.actions.client',
            'tag': 'display_notification',
            'params': {
                'title': _('Success!'),
                'message': 'تم تأكيد العملية بنجاح',
                'sticky': False,
            }

        }
        
        return message

    def display_employees(self):
        empolyees = self.env['hr.employee'].search([('emplo_checkbox', '=', 'True')])
        employee_isExist = self.env['hrsystem.transactiondetails'].search([('transaction_id', '=', self.id)])
        if employee_isExist:
                raise ValidationError ("Employees already exist") 
        for item in empolyees:
            loan = self.env['hrsystem.loan'].search(
                [('employee_id', '=', item.id),('month', '=', self.month),('state', '=', 'posted')])
            
            loan_total = 0 
            for line in loan:
                loan_total += line.amount
           
            off_days = self.env['hrsystem.offdays'].search(
                [('employee_id', '=', item.id),('month', '=', self.month),('state', '=', 'posted')])
            
            off_days_total = 0
            for line in off_days:
                off_days_total += line.number_of_days
           
            
            compute_discount = item.total_salary / 30
            discount = compute_discount * off_days_total
            
          
            employee = self.env['hrsystem.transactiondetails'].create({
                'empolyee_id': item.id,
                'net_salary': item.total_salary - (loan_total + discount) ,
                'rewards': 0,
                'discount': 0,
                'month': self.month,
                'year': self.year,
                'off_days': off_days_total,
                'loan': loan_total,
                'total_salary':item.total_salary,
                'transaction_id': self.id
            })
        self.write({'state': 'in_complete'})
    
    def get_invoices (self): 
        action = self.env.ref('account.action_move_in_invoice_type')
        result = action.read()[0]
        result.pop('master_id',None)
        result['context'] ={}
        result['domain'] = [('master_id','=',self.id)]
        return result
          
          

class transaction_details(models.Model):
    _name = 'hrsystem.transactiondetails'
    _description = 'hr system transaction details'

    empolyee_id = fields.Many2one('hr.employee')
    net_salary = fields.Float(string="صافي الراتب",readonly=True)
    rewards = fields.Float(string="المكافات ")
    discount = fields.Float(string="الخصومات ",readonly=True)
    month = fields.Char(string="الشهر ",readonly=True)
    year = fields.Char(string="السنة ",readonly=True)
    off_days = fields.Integer(string="أيام الغياب",readonly=True)
    loan = fields.Float(string="السلفات ",readonly=True)
    total_salary=fields.Float(string="إجمالي الراتب",readonly=True)
    transaction_id = fields.Many2one('hrsystem.transaction')

    @api.onchange('rewards')
    def compute_rewards(self):
        total = 0
        total = self.rewards + self.net_salary
        self.net_salary = total


        
   