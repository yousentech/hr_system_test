from odoo import models, fields ,api
from odoo.exceptions import ValidationError

class Departments(models.Model):

    _name='hrsystem.departments'
    deptname=fields.Char(string="اسم القسم",help="long desc",index=True)
    
