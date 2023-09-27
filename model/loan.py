from odoo import api, models, fields
from odoo import date
class loan(models.Model):
    _name = 'hr.loan'

    employee_id = fields.Char(string="اسم الموظف ", required=True)
    date = fields.Date(string="التاريخ", required=True,copy=False)
    state= fields.Selection([('not_posted','غير معتمد'),('posted','معتمد')],default="not_posted",readonly=True) 
    amount=fields.Float(string="التاريخ", required=True,)