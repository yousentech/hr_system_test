from odoo import models, fields ,api
from odoo.exceptions import ValidationError



class MasterEmployee(models.Model):

    _inherit='hr.employee'
    _rec_name='name'
    total_salary=fields.Float(string="إجمالي الراتب",help="long desc",index=True)
    emplo_checkbox = fields.Boolean(string='موظف لدينا')

    _sql_constraints = [
        ('check_total_salary_positive', 'CHECK(total_salary >= 0)', 'يجب أن يكون إجمالي الراتب أكبر من أو يساوي صفر.'),
    ]
    # departments_id=fields.Many2one('hrsystem.departments',string="اسم القسم")
    # employee_name=fields.Char(string="إسم الموظف",help="long desc",index=True)
    # emplo_age=fields.Integer(string="العمر")
    # emplo_address=fields.Char(string=" العنوان",help="long desc",index=True)
    # emplo_email=fields.Char(string=" البريد الالكتروني",help="long desc",index=True)
    # emplo_personal_card_num=fields.Integer(string="رقم البطاقة الشخصية")
    # odoo_emplo_ids=fields.One2many('hr.employee','emp_master_id')
    detail_ids=fields.One2many('hrsystem.details','emp_master_id')
    # partner_id = fields.Many2one('res.partner', string='Partner')
    # @api.model
    # def create(self, vals):
    #     partner = self.env['res.partner'].create({
    #         'name': vals.get('name'),
    #         # قم بإضافة المزيد من الحقول الأخرى في "res.partner" التي ترغب في تعيينها من "hr.employee"
    #     })
    #     vals['partner_id'] = partner.id
    #     return super(MasterEmployee, self).create(vals)



            
class Details(models.Model):
    _name='hrsystem.details'
    # _rec_name='name'
    # product_type=fields.Char(string="نوع المنتج",required=True,help="long desc",index=True)
    net_salary=fields.Float(string="صافي الراتب",help="long desc",index=True)
    rewards=fields.Float(string="المكافات ",help="long desc",index=True)
    discount=fields.Float(string="الخصومات ",help="long desc",index=True)
    _sql_constraints = [
        ('check_net_salary_positive', 'CHECK(net_salary >= 0)', 'يجب أن يكون صافي الراتب أكبر من أو يساوي صفر.'),
        ('check_rewards_positive', 'CHECK(rewards >= 0)', 'يجب أن تكون المكافات أكبر من أو يساوي صفر.'),
        ('check_discount_negative', 'CHECK(discount <= 0)', 'يجب أن تكون الخصومات أقل من أو تساوي صفر.'),
    ]
    # @api.model
    # def _get_month_selection(self):
    #     current_month = datetime.datetime.now().month
    #     months = [(str(i), datetime.date(1900, i, 1).strftime('%B')) for i in range(1, 13)]
    #     return months[current_month - 1:]

    # @api.model
    # def _get_year_selection(self):
    #     current_year = datetime.datetime.now().year
    #     years = [(str(i), str(i)) for i in range(current_year - 10, current_year + 1)]
    #     return years

    # month = fields.Selection(selection='_get_month_selection', string='الشهر', help='وصف طويل', index=True)
    # year = fields.Selection(selection='_get_year_selection', string='السنة', help='وصف طويل', index=True)

    month=fields.Char(string="الشهر ",help="long desc",index=True)
    year=fields.Char(string="السنة ",help="long desc",index=True)
    off_days=fields.Integer(string="أيام الغياب")
    
    emp_master_id = fields.Many2one('hr.employee')   


    