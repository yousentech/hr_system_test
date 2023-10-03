from odoo import models, fields ,api
import datetime

class MyWizardOneEmployee(models.TransientModel):
    _name = 'hrsystem.wizard_one_employee'
    _description = 'My Wizard Report'
    emplo_id=fields.Many2one("hr.employee",domain=[('emplo_checkbox','=','True')],string="اسم الموظف" ,required=True)
    def print_report(self):
        data={
            'id':self.emplo_id.id,
            'name':self.emplo_id.name,
                    }
        return self.env.ref('hr_system_test.report_invoice_generate_one').report_action(self, data=data)
    


class OpenPDF(models.AbstractModel):
    _name='report.hr_system_test.report_generate_template22'

    def _get_report_values(self, docids, data=None):
        domain = []
        if data.get('id'):
            print(data.get('id'),"jjjjjjjjjjjjjjjj")
            domain.append(('id', 'in', [data.get('id')]))
            
       


        docs = self.env['hr.employee'].search(domain)
      
        
        print("hhhhhhhhhhh",docs )
        print("hhhhhhhhhhh",data )
        print("=======================================")
        return {
            'doc_ids': docs.ids,
            'doc_model': 'hrsystem.wizard_one_employee',
            'docs': docs,
            'datas': data
        }
    

class MyWizard(models.TransientModel):
    _name = 'hrsystem.wizard'
    _description = 'My Wizard Report'
    @api.model
    def _get_month_selection(self):
        
        months = [(str(i), datetime.date(1900, i, 1).strftime('%B')) for i in range(1, 13)]
        return months

    @api.model
    def _get_year_selection(self):
        current_year = datetime.datetime.now().year
        years = [(str(i), str(i)) for i in range(current_year - 10, current_year + 1)]
        return years

    month = fields.Selection(selection='_get_month_selection', string='الشهر', help='وصف طويل', index=True,)
    year = fields.Selection(selection='_get_year_selection', string='السنة', help='وصف طويل', index=True,

    )
    
    def print_report(self):
        data={
            'month':self.month,
            'year':self.year,
                    }
        return self.env.ref('hr_system_test.report_invoice_generate').report_action(self, data=data)
    


class OpenPDF(models.AbstractModel):
    _name='report.hr_system_test.report_generate_template2'

    def _get_report_values(self, docids, data=None):
        domain = []
        if data.get('month'):
            domain.append(('month', '=', data.get('month')))
        if data.get('year'):
            domain.append(('year', '=',data.get('year')))
       


        docs = self.env['hrsystem.transactiondetails'].search(domain)
      
        for i in docs:

            print("hhhhhhhhhhh",i )
        print("hhhhhhhhhhh",data )
        print("=======================================")
        return {
            'doc_ids': docs.ids,
            'doc_model': 'hrsystem.wizard',
            'docs': docs,
            'datas': data
        }
    
