// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hr_mobile/model/employee_model.dart';

import 'package:hr_mobile/string/string.dart';

class EmployeeDetails extends StatelessWidget {
  EmployeesdetailModel employeesdetail;
  EmployeeDetails({
    super.key,
    required this.employeesdetail,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        shrinkWrap: true,
        primary:true ,
        physics:const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          DataTable(
            columns: const [
              DataColumn(
                label: Text(
                  'netSalary',
                ),
              ),
              DataColumn(label: Text('rewards')),
              DataColumn(label: Text('discount')),
              DataColumn(label: Text('offDays')),
              DataColumn(label: Text('loan')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text(
                  employeesdetail.netSalary.toString(),
                  style: errorstyle,
                )),
                DataCell(Text(
                  employeesdetail.rewards.toString(),
                  style: errorstyle,
                )),
                DataCell(Text(
                  employeesdetail.discount.toString(),
                  style: errorstyle,
                )),
                DataCell(Text(
                  employeesdetail.offDays.toString(),
                  style: errorstyle,
                )),
                DataCell(Text(
                  employeesdetail.loan.toString(),
                  style: errorstyle,
                )),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
