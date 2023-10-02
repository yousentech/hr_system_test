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
       @api.model
       def _get_year_selection(self):
          current_year = datetime.datetime.now().year
          years = [(str(i), str(i)) for i in range(current_year - 10, current_year + 1)]
          return years

       year = fields.Selection(selection='_get_year_selection', string='السنة', index=True)
       def confirm(self):
        offday_in_this_month=self.env['hrsystem.offdays'].search([('state', '=', 'posted'),('employee_id', '=', self.employee_id.id),('month', '=', self.month),('year', '=', self.year)])

        if self.number_of_days > 3 :
           raise ValidationError ("ايام الاجازة تجاوز الحد المسموح ") 
         

        elif offday_in_this_month.number_of_days > 3 :
               raise ValidationError ("ايام الاجازة تجاوز الحد المسموح ") 
        else:
           self.write({'state': 'posted'})
          
       def unconfirm(self):
              self.write({'state': 'not_posted'})
       
      