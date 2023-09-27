from odoo import models, fields ,api
from odoo.exceptions import ValidationError

class OdooEmployee(models.Model):
    _inherit = 'hr.employee'
    # emp_master_id = fields.Many2one('hrsystem_system_test.employeemaster') 



class MasterEmployee(models.Model):

    _inherit='hr.employee'
    total_salary=fields.Float(string="إجمالي الراتب",help="long desc",index=True)
    emplo_checkbox = fields.Boolean(string='موظف لدينا')
    departments_id=fields.Many2one('hrsystem.departments',string="اسم القسم")
    # departments_id=fields.One2many('hrsystem_system_test.departments','master_id')
    # employee_name=fields.Char(string="إسم الموظف",help="long desc",index=True)
    # emplo_age=fields.Integer(string="العمر")
    # emplo_address=fields.Char(string=" العنوان",help="long desc",index=True)
    # emplo_email=fields.Char(string=" البريد الالكتروني",help="long desc",index=True)
    # emplo_personal_card_num=fields.Integer(string="رقم البطاقة الشخصية")
    # odoo_emplo_ids=fields.One2many('hr.employee','emp_master_id')
    detail_ids=fields.One2many('hrsystem.details','emp_master_id')
   



            
class Details(models.Model):
    _name='hrsystem.details'
    
    # product_type=fields.Char(string="نوع المنتج",required=True,help="long desc",index=True)
    net_salary=fields.Float(string="صافي الراتب",help="long desc",index=True)
    rewards=fields.Float(string="المكافات ",help="long desc",index=True)
    discount=fields.Float(string="الخصومات ",help="long desc",index=True)
    mounth=fields.Integer(string="الشهر ",help="long desc",index=True)
    year=fields.Integer(string="السنة ",help="long desc",index=True)
    off_days=fields.Integer(string="أيام الغياب")
    
    emp_master_id = fields.Many2one('hrsystem_system_test.employeemaster')   


    