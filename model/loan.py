from odoo import api,models,fields
from datetime import date



class loan(models.Model):
       _name='hrsystem.loan'


       employee_id=fields.Many2one('hr.employee',string="اسم الموظف" ,required=True)
       date=fields.Date(string="تاريخ السلفة ")
       amount=fields.Float(string="مبلغ السلفة ")
   