from odoo import api,models,fields
import datetime
from odoo.exceptions import ValidationError

class loan(models.Model):
       _name='hrsystem.loan'
       _description='info about the loans of  employee'
       _rec_name='employee_id'

       employee_id=fields.Many2one('hr.employee',domain=[('emplo_checkbox','=','True')],string="اسم الموظف" ,required=True)
       amount=fields.Float(string="مبلغ السلفة ")
       state= fields.Selection([('not_posted','غير مرحل'),('posted','مرحل')],default="not_posted",readonly=True) 
       journal_id=fields.Many2one( 'account.journal',domain=[('type','in',['cash','bank'])],string="دفتر اليومية")
       payment_id=fields.Many2one('account.payment',string='رقم الدفعة')
       @api.model
       def _get_month_selection(self):
        months = [(str(i), datetime.date(1900, i, 1).strftime('%B')) for i in range(1, 13)]
        return months
       
       month = fields.Selection(selection='_get_month_selection', string='الشهر', index=True)
       def confirm(self):
          self.write({'state': 'posted'})
          
       def unconfirm(self):
              self.write({'state': 'not_posted'})
       
       @api.model
       def _get_year_selection(self):
          current_year = datetime.datetime.now().year
          years = [(str(i), str(i)) for i in range(current_year - 10, current_year + 1)]
          return years

       year = fields.Selection(selection='_get_year_selection', string='السنة', index=True)
       
     
      
       def unlink(self):
           
              if self.state == 'posted':
                raise ValidationError ("لا يمكن الحذف  ")  
         
              return super(loan,self).unlink()
 
          
       def get_payment (self):
            print("***************",self.payment_id.id)
            self.ensure_one()
            return {
            'type': 'ir.actions.act_window',
            'name': 'فاتورة السلفة ',
            'view_mode': 'tree',
            'res_model': 'account.payment',
            'domain': [('id', '=', self.payment_id.id)],
            'context': "{}"
        } 
       def confirm(self):
             #code to compute amount of loans and compare it with the net salary
            daysoff=0
            amount_of_loans=0
            amount_after_discount=0
            employee_loans_in_one_month = self.env['hrsystem.loan'].search([('state', '=', 'posted'),('employee_id.id', '=', self.employee_id.id),('month', '=', self.month),('year', '=', self.year)])
            for loan in employee_loans_in_one_month:
                  amount_of_loans=amount_of_loans+employee_loans_in_one_month.amount
            employee=self.env['hr.employee'].search([('id', '=', self.employee_id.id)])
          
            offday_in_this_month=self.env['hrsystem.offdays'].search([('state', '=', 'posted'),('employee_id.id', '=', self.employee_id.id),('month', '=', self.month),('year', '=', self.year)])
            for days in offday_in_this_month:
             daysoff=daysoff+days.number_of_days
            if daysoff > 1:
                compute_discount = employee.total_salary / 30
                discount = compute_discount * daysoff
                amount_after_discount = employee.total_salary - discount
            if amount_of_loans > amount_after_discount:   
               raise ValidationError ("لا يمكن اضافة سلفة  ") 
              
            else:
                  
             payment = self.env['account.payment'].create({
                'date': datetime.datetime.now(),
                'payment_type':'outbound',
                'partner_id':self.employee_id.partner_id.id,
                'amount': self.amount,
                'journal_id': self.journal_id.id,
                  })
             payment.action_post()
             self.payment_id=payment.id
             self.write({'state': 'posted'})
            
