from odoo import api,models,fields
from datetime import date
from odoo.exceptions import ValidationError


class loan(models.Model):
       _name='hrsystem.loan'
       _description='info about the loans of  employee'
       _rec_name='employee_id'


       employee_id=fields.Many2one('hr.employee',string="اسم الموظف" ,required=True)
       date=fields.Date(string="تاريخ السلفة ")
       amount=fields.Float(string="مبلغ السلفة ")
       
       @api.constrains('date')
       def _check_date_end(self):
        for record in self:
         if record.date > fields.Date.today():
            raise ValidationError("التاريخ لا يجب ان يكون في المستقبل")
   