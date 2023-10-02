import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_mobile/controller/offdays_controller.dart';
import 'package:hr_mobile/model/offday_model.dart';
import 'package:hr_mobile/string/colors.dart';
import 'package:hr_mobile/string/string.dart';
import 'package:hr_mobile/view/accountStatement.dart';
import 'package:hr_mobile/widget/button.dart';
import 'package:hr_mobile/widget/textField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateOffdays extends StatefulWidget {
  const CreateOffdays({super.key});

  @override
  State<CreateOffdays> createState() => _CreateOffdaysState();
}

class _CreateOffdaysState extends State<CreateOffdays> {
  final OffdaysController controller = Get.put(OffdaysController());
  bool flag = false;
  final TextEditingController date = TextEditingController();
  final TextEditingController numberOfDays = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );

    if (pickedDate != null) {
      setState(() {
        date.text = pickedDate.toString().substring(0, 10);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Off Day Page"),
            centerTitle: true,
          ),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                ContainerTextField(
                  controller: date,
                  readOnly: true,
                  prefixIcon: const Icon(Icons.date_range_outlined),
                  hintText: 'Date',
                  labelText: 'Date',
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                ContainerTextField(
                  controller: numberOfDays,
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.numbers),
                  hintText: 'Number Of Days',
                  labelText: 'Number Of Days',
                ),
                controller.offdayLoading.value == true
                    ? const CircularProgressIndicator()
                    : ButtonElevated(
                        text: "Send",
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          var employeeId = prefs.getInt('employee_Id');
                          if (!_formKey.currentState!.validate()) {
                          } else {
                            print("object;");
                            print(employeeId);
                            OffdaysModel offdayModel = OffdaysModel(
                                employeeId: employeeId.toString(),
                                date: date.text,
                                numberOfDays: numberOfDays.text);
                            print(offdayModel.toJson());
                            controller.createOffDay(offdayModel).then((value) {
                              if (value) {
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text(
                                      'Success Message',
                                      style: focusstyle,
                                    ),
                                    content: const Text(
                                      'Complete Successfully',
                                      style: subtitlestyle,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.to(() =>
                                              const AccountStatementUser());
                                          // Get.to((){AccountStatementUser()});
                                          // Get.back(); // Close the dialog
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                                // Get.to(() => const LoanPage());
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
                      )
              ],
            ),
          )),
    );
  }
}
