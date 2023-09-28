
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
                'security/security.xml',
                'views/loan.xml',
                
              
                'views/loan.xml',
               
                'views/offdays.xml',
                # 'views/transaction.xml',
                'views/transaction.xml',
               
               'views/employee.xml',
               'views/departments.xml',
               'views/products.xml',
               'views/menus.xml',
               'views/employee_report.xml',
                'views/one_employee_report.xml',
                'views/menus.xml',
              
         ],
     
'qweb': [
    'static/src/fonts/K2FhfZBRmr9vQ1pHEey6GIGo8_pv3myYjuXwe55ijDz-oQ.woff2',
],
'images':[
     'static/images/code.png',
    'static/src/img/hero-bg.png',
 'static/src/img/hero-img.png', 
 'static/src/img/team-shape.png',
   
],

    'license': 'LGPL-3',
    'images': [],
    'sequence':'-100',
    'installable': True,
    'auto_install': False,
    'application': True,
}
