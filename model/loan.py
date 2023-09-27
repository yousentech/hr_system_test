from odoo import api,models,fields
from datetime import date
from odoo.exceptions import ValidationError


class payment_employee_id(models.Model):
       _inhert='account.payment'
       employee_id=fields.Many2one('hr.employee',string="اسم الموظف")


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
       
       @api.constrains('date')
       def _check_date_end(self):
        for record in self:
         if record.date > fields.Date.today():
            raise ValidationError("التاريخ لا يجب ان يكون في المستقبل")
        
       def confirm(self):
            print("self.employee_id.ids",self.employee_id.ids)  
            partner_id = self.env['res.partner'].search([('employee_ids.id','=',self.employee_id.id)]) 
            print("partner_id",partner_id)  
            payment = self.env['account.payment'].create({
                'date': self.date,
                # 'payment_method_line_id': self.pay_way,

                # 'payment_method_id': self.inbound_payment_method.id,
                'payment_type': 'outbound',
                'partner_id': partner_id.id,
                'amount': self.amount,
               # 'employee_id':self.employee_id.id,
                'journal_id': self.journal_id.id,
               
                  })
            payment.action_post()
            self.payment_id=payment.id
            self.write({'state': 'posted'})
            