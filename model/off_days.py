from odoo import api,models,fields
from datetime import date
from odoo.exceptions import ValidationError


class off_days(models.Model):
       _name='hrsystem.offdays'
       _description='info about the days off of the  employee'
       _rec_name='employee_id'


       employee_id=fields.Many2one('hr.employee',string="اسم الموظف" ,required=True)
       month=fields.Integer(string="الشهر ",required=True)
       number_of_days=fields.Integer(string="عدد ايام الاجازة  ")
   