from odoo import api, models, fields,exceptions, _
class transaction_master(models.Model):
    _name = 'hrsystem.transaction'
    _description = 'hr system transaction'

    _rec_name = 'month'
    _order = 'month ASC'
    
    month = fields.Date(string="الشهر")
    year = fields.Date(string="السنة")
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
    mounth=fields.Date(string="الشهر ",help="long desc",index=True)
    year=fields.Date(string="السنة ",help="long desc",index=True)
    off_days=fields.Integer(string="أيام الغياب")
    
    transaction_id = fields.Many2one('hrsystem.transaction') 
        
        
        
           
      
