import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_mobile/controller/login_controller.dart';
import 'package:hr_mobile/model/login_model.dart';
import 'package:hr_mobile/string/colors.dart';
import 'package:hr_mobile/string/string.dart';
import 'package:hr_mobile/view/accountStatement.dart';
import 'package:hr_mobile/view/all_employees.dart';
import 'package:hr_mobile/view/createEmployee.dart';
import 'package:hr_mobile/view/createoffdays.dart';
import 'package:hr_mobile/view/loanPage.dart';
import 'package:hr_mobile/widget/button.dart';
import 'package:hr_mobile/widget/textField.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool flag = false;
  final LoginController controller = Get.put(LoginController());
  final TextEditingController login = TextEditingController();
  final TextEditingController password = TextEditingController();
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
                height: MediaQuery.of(context).size.height / 2,
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
                controller: login,
                prefixIcon: const Icon(Icons.done),
                hintText: 'DataBase Name',
                labelText: 'DataBase Name',
              ),
              ContainerTextField(
                controller: password,
                prefixIcon: const Icon(Icons.lock),
                hintText: 'Password',
                labelText: 'Password',
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        flag = !flag;
                      });
                    },
                    icon: flag
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off)),
                obscureText: flag ? false : true,
              ),
              Obx(() {
                if (controller.authenticateLoading.value) {
                  return const CircularProgressIndicator();
                } else {
                  return ButtonElevated(
                    text: 'Login',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        LoginModel loginModel = LoginModel(
                            db: 'mydb',
                            login: login.text,
                            password: password.text);
                        controller.authenticate(loginModel).then((value) {
                          if (value) {
                            Get.to(() => const AllEmployees());
                            // Get.to(() => const CreateOffdays());
                            // Get.to(() => const AccountStatementUser());
                            // Get.to(() => const LoanPage());
                            // Get.to(() => const CreateEmployee());
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
