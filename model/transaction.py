from odoo import api, models, fields, exceptions, _
import datetime
class CashFlow(models.Model):
   _inherit = 'account.move'

   master_id = fields.Many2one('hrsystem.transaction', required=True,copy=False)

class transaction_master(models.Model):
    _name = 'hrsystem.transaction'
    _description = 'hr system transaction'

    _rec_name = 'month'
    _order = 'month ASC'

    month = fields.Date(string="الشهر")
    year = fields.Date(string="السنة")
    # journal_id = fields.Many2one('account.journal',domain=[('type','in',['purchase'])],string='نوع الفاتورة')
    transaction_details_ids = fields.One2many(
        'hrsystem.transactiondetails', 'transaction_id')

    def convirm(self):
        empolyees = self.env['hr.employee'].search([])

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
            print('=======recorde===========',recorde)
            invoice_details = []
            get_employee_detail = self.env['hrsystem.details'].search([('emp_master_id', '=', item.id)])
            
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
            print('=======product_loan===oooooooooooooooooooooo========',product_loan.id,product_salary.id)
        
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
                'price_unit': recorde.total_salary

            }
            invoice_details.append((0, 0, product_off_days_object))
            print('========invoice_details======',invoice_details)
            jurnal_value = self.env['account.journal'].search([('type', '=', 'purchase')])
            invoice = self.env['account.move'].create({
                'move_type': 'in_invoice',
                'partner_id': recorde.parent_id_id.id,
                'invoice_date': self.month,
                'journal_id': jurnal_value.id,
                'invoice_line_ids': invoice_details,
                'master_id': self.id
            })
            invoice.action_post()
          
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
        empolyees = self.env['hr.employee'].search([])
        for item in empolyees:
            loan = self.env['hrsystem.loan'].search(
                [('employee_id', '=', item.id)])
            off_days = self.env['hrsystem.offdays'].search(
                [('employee_id', '=', item.id)])
            employee = self.env['hrsystem.transactiondetails'].create({
                'empolyee_id': item.id,
                'net_salary': item.total_salary,
                'rewards': 0,
                'discount': 0,
                'month': self.month,
                'year': self.year,
                'off_days': off_days.number_of_days,
                'loan': loan.amount,
                'transaction_id': self.id
            })


class transaction_details(models.Model):
    _name = 'hrsystem.transactiondetails'
    _description = 'hr system transaction details'

    empolyee_id = fields.Many2one('hr.employee')
    net_salary = fields.Float(string="صافي الراتب",)
    rewards = fields.Float(string="المكافات ",)
    discount = fields.Float(string="الخصومات ",)
    month = fields.Date(string="الشهر ",)
    year = fields.Date(string="السنة ",)
    off_days = fields.Integer(string="أيام الغياب")
    loan = fields.Float(string="السلفات ",)
    transaction_id = fields.Many2one('hrsystem.transaction')

    @api.onchange('rewards')
    def compute_rewards(self):
        total = 0
        total = self.rewards + self.net_salary
        self.net_salary = total

    @api.depends('off_days')
    def compute_discount(self):
        compute_discount = self.net_salary / 30
        self.discount = compute_discount * self.off_days
        amount_after_discount = self.net_salary - self.discount
        self.net_salary = amount_after_discount
