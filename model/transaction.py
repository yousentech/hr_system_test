from odoo import api, models, fields,exceptions, _
class transaction(models.Model):
    _name = 'hrsystem.transaction'
    _description = 'hr system transaction'

    _rec_name = 'month'
    _order = 'month ASC'
    

    month = fields.Date(string="الشهر")
    year = fields.Date(string="السنة")
  