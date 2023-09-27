from odoo import models, fields ,api

class Products(models.Model):

    _inherit='product.template'
    _rec_name='name'
    products_select=fields.Selection([
        ('prod_salary', 'راتب'),
        ('prod_off_days', 'إجازة'),
        ('prod_reward', 'مكافأة'),
        ('prod_on_account', 'سلفة'),
    ])