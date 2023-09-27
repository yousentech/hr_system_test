
{
    'name': 'HR_System',
    'version': '16.0.2.0.7',
    'category': 'HR_System',
    'summary': """HR_System.""",
    'description': """
                     HR_System
                    """,
    'author': 'yousen tech Techno Solutions, Odoo SA',
    'website': "https://www.qimamhd.com",
    'company': 'yousen Techno Solutions',
    'maintainer': 'yousen Techno Solutions',
    'depends': ['base','account','hr','stock','report_xlsx'],
    'data': [   
                'security/ir.model.access.csv',
                'views/loan.xml',
                'views/menus.xml',
                'views/offdays.xml',
               
               'views/employee.xml',
               'views/departments.xml',
              
         ],
     
    'license': 'LGPL-3',
    'images': [],
    'sequence':'-100',
    'installable': True,
    'auto_install': False,
    'application': True,
}
