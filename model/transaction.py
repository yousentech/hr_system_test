from odoo import api, models, fields,exceptions, _
import datetime
class transaction_master(models.Model):
    _name = 'hrsystem.transaction'
    _description = 'hr system transaction'

    _rec_name = 'month'
    _order = 'month ASC'
    
    @api.model
    def _get_month_selection(self):
        months = [(str(i), datetime.date(1900, i, 1).strftime('%B')) for i in range(1, 13)]
        return months

    @api.model
    def _get_year_selection(self):
        current_year = datetime.datetime.now().year
        years = [(str(i), str(i)) for i in range(current_year - 10, current_year + 1)]
        return years

    month = fields.Selection(selection='_get_month_selection', string='الشهر', help='وصف طويل', index=True)
    year = fields.Selection(selection='_get_year_selection', string='السنة', help='وصف طويل', index=True)
            
    transaction_details_ids=fields.One2many('hrsystem.transactiondetails','transaction_id')
   
    def convirm(self):
        return {}
    
    def display_employees(self):
        empolye = self.env['hr.employee'].search([])
        # for rec in empolye : 
        #     for item in self.employees_ids:
        # for rec in self:
        employees = []

        for item in empolye:
                print('=======item=======',item) 
                employees_object = {
                    'empolyee_id':item.name,
                    'net_salary':item.net_salary,
                
                    
                    }
                employees.append((0, 0, employees_object))
        print('=======employees=======',employees)
        self.env['hrsystem.transaction'].update({
                    'transaction_details_ids':employees
                    })
        
class transaction_details(models.Model):
    _name = 'hrsystem.transactiondetails'
    _description = 'hr system transaction details'
    
    empolyee_id = fields.Many2one('hr.employee') 
    net_salary=fields.Float(string="صافي الراتب",help="long desc",index=True)
    rewards=fields.Float(string="المكافات ",help="long desc",index=True)
    discount=fields.Float(string="الخصومات ",help="long desc",index=True)
    mounth=fields.Char(string="الشهر ",help="long desc",index=True)
    year=fields.Char(string="السنة ",help="long desc",index=True)
    off_days=fields.Integer(string="أيام الغياب")
    
    transaction_id = fields.Many2one('hrsystem.transaction') 
        
        
      
      
