from odoo import api,models,fields
from datetime import date
from odoo.exceptions import ValidationError

class loan(models.Model):
       _name='hrsystem.loan'
       _description='info about the loans of  employee'
       _rec_name='employee_id'

       employee_id=fields.Many2one('hr.employee',domain=[('emplo_checkbox','=','True')],string="اسم الموظف" ,required=True)
       date=fields.Date(string="تاريخ السلفة ")
       amount=fields.Float(string="مبلغ السلفة ")
       state= fields.Selection([('not_posted','غير مرحل'),('posted','مرحل')],default="not_posted",readonly=True) 
       journal_id=fields.Many2one( 'account.journal',domain=[('type','in',['cash','bank'])],string="دفتر اليومية")
       payment_id=fields.Many2one('account.payment',string='رقم الدفعة')
       
       def unlink(self):
           
              if self.state == 'posted':
                raise ValidationError ("لا يمكن الحذف  ")  
         
              return super(loan,self).unlink()
 
       @api.constrains('date')
       def _check_date_end(self):
        for record in self:
         if record.date > fields.Date.today():
            raise ValidationError("التاريخ لا يجب ان يكون في المستقبل")
          
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
            payment = self.env['account.payment'].create({
                'date': self.date,
                'payment_type':'outbound',
                'partner_id':self.employee_id.partner_id.id,
                'amount': self.amount,
                'journal_id': self.journal_id.id,
                  })
            payment.action_post()
            self.payment_id=payment.id
            self.write({'state': 'posted'})
            
