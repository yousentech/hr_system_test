from odoo import api,models,fields
import datetime
from odoo.exceptions import ValidationError


class off_days(models.Model):
       _name='hrsystem.offdays'
       _description='info about the days off of the  employee'
       _rec_name='employee_id'


       employee_id=fields.Many2one('hr.employee',domain=[('emplo_checkbox','=','True')],string="اسم الموظف" ,required=True)
       number_of_days=fields.Integer(string="عدد ايام الاجازة  ")
       state= fields.Selection([('not_posted','غير معتمد'),('posted','معتمد')],string="الحالة ",default="not_posted",readonly=True) 

       @api.model
       def _get_month_selection(self):
        months = [(str(i), datetime.date(1900, i, 1).strftime('%B')) for i in range(1, 13)]
        return months
       
       month = fields.Selection(selection='_get_month_selection', string='الشهر', index=True)
       def confirm(self):
          self.write({'state': 'posted'})
          
       def unconfirm(self):
              self.write({'state': 'not_posted'})
     