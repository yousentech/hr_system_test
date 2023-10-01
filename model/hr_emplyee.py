from odoo import models, fields ,api
from odoo.exceptions import ValidationError



class MasterEmployee(models.Model):

    _inherit='hr.employee'
    _rec_name='name'
    total_salary=fields.Float(string="إجمالي الراتب",help="long desc",index=True)
    password=fields.Char(string="كلمة المرور ",help="long desc",index=True)
  

    emplo_checkbox = fields.Boolean(string='موظف لدينا')
    partner_id=fields.Many2one('res.partner',string='اسم الشريك ')
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
   





            
class Details(models.Model):
    _name='hrsystem.details'
    # _rec_name='name'
    # product_type=fields.Char(string="نوع المنتج",required=True,help="long desc",index=True)
    net_salary=fields.Float(string="صافي الراتب",help="long desc",index=True)
    rewards=fields.Float(string="المكافات ",help="long desc",index=True)
    discount=fields.Float(string="الخصومات ",help="long desc",index=True)
    mounth=fields.Char(string="الشهر ",help="long desc",index=True)
    year=fields.Char(string="السنة ",help="long desc",index=True)
    off_days=fields.Integer(string="أيام الغياب")
    loan = fields.Float(string="السلفات ",)
    emp_master_id = fields.Many2one('hr.employee')   


    