import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_mobile/controller/employee_controller.dart';
import 'package:hr_mobile/model/employee_model.dart';
import 'package:hr_mobile/string/colors.dart';
import 'package:hr_mobile/string/string.dart';
import 'package:hr_mobile/view/accountStatement.dart';
import 'package:hr_mobile/view/loanPage.dart';
import 'package:hr_mobile/widget/button.dart';
import 'package:hr_mobile/widget/textField.dart';

class CreateEmployee extends StatefulWidget {
  const CreateEmployee({super.key});

  @override
  State<CreateEmployee> createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  bool flag = false;
  final EmployeeController controller = Get.put(EmployeeController());
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: const BoxDecoration(
                    color: deepPurple,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: const Center(
                  child: Text.rich(
                      TextSpan(text: 'WELCOME ', style: titlestyle, children: [
                    TextSpan(
                      text: '\n       In HR App',
                      style: subtitlestyle,
                    )
                  ])),
                ),
              ),
              ContainerTextField(
                controller: name,
                prefixIcon: const Icon(Icons.person_2_outlined),
                hintText: 'Employee Name',
                labelText: 'Employee Name',
              ),
              ContainerTextField(
                controller: email,
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                labelText: 'Email',
              
              ),
              ContainerTextField(
                controller: phone,
                prefixIcon: const Icon(Icons.phone_android),
                hintText: 'Phone Number',
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
                
              ),
              Obx(() {
                if (controller.employeeLoading.value) {
                  return const CircularProgressIndicator();
                } else {
                  return ButtonElevated(
                    text: 'Create',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        EmployeesModel createEmployee = EmployeesModel(
                            
                            name: name.text,
                            phone: phone.text,
                            workEmail: email.text,
                            emploCheckbox: true,);
                        controller
                            .createEmployee(createEmployee: createEmployee)
                            .then((value) {
                          if (value) {
                            // Get.to(() => const AccountStatementUser());
                            Get.to(() => const LoanPage());
                          } else {
                            Get.snackbar(
                                'error maseeg', 'Please check the entries',
                                titleText: const Text(
                                  'error maseeg',
                                  style: subtitlestyle,
                                ),
                                messageText: const Text(
                                  'Please check the entries',
                                  style: subtitlestyle,
                                ),
                                duration: const Duration(seconds: 5),
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: deepPurple);
                          }
                        });
                      }
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
