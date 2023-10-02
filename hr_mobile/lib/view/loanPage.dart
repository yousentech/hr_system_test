import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_mobile/model/loan_model.dart';
import 'package:hr_mobile/string/string.dart';
import 'package:hr_mobile/view/accountStatement.dart';
import 'package:hr_mobile/widget/button.dart';
import 'package:hr_mobile/widget/textField.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/loan_controller.dart';
import '../string/colors.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  final LoanController controller = Get.put(LoanController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController date = TextEditingController();
  final TextEditingController amount = TextEditingController();
  List allEmployees = [];
  // List allgetJournalIds = [];
  String _selectedEmployee = '';
  String _selectedJournalId = '';
  // String _valueEmployee = '';
  String _valueJournalId = '';

  getEmployees() async {
    var getEmployee = await controller.getEmployee();
    allEmployees = getEmployee;
  }

  getJournalIds() async {
    controller.getJournalId();
    // var getJournalId = await controller.getJournalId();
    // allgetJournalIds = getJournalId;
  }

  _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );

    if (pickedDate != null) {
      setState(() {
        date.text = pickedDate.toString().substring(0, 11);
      });
    }
  }

  @override
  void initState() {
    getEmployees();
    getJournalIds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("LoanPage"),
            centerTitle: true,
          ),
          body: controller.loanLoading.value == true
              ? const CircularProgressIndicator()
              : Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // popupMenu(allEmployees),
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
                        controller: amount,
                        prefixIcon: const Icon(Icons.monetization_on_outlined),
                        hintText: 'amount',
                        labelText: 'amount',
                      ),
                      GetBuilder<LoanController>(
                        init: LoanController(),
                        builder: (controller) {
                          return popupMenujournal(
                            controller.getJournalIds,
                          );
                        },
                      ),

                      controller.createLoading.value == true
                          ? const CircularProgressIndicator()
                          : ButtonElevated(
                              text: "Send",
                              onPressed: () async {
                                print("hhhhwe");
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                var employeeId = prefs.getInt('employee_Id');
                                print(employeeId);
                                if (!_formKey.currentState!.validate()) {
                                } else {
                                  if (_selectedJournalId.isEmpty) {
                                    Get.snackbar('error maseeg',
                                        'Please check the entries',
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
                                  } else {
                                    print("object;");
                                    LoanModel loanModel = LoanModel(
                                        employeeId: employeeId.toString(),
                                        // _valueEmployee,
                                        date: date.text,
                                        amount: int.parse(amount.text),
                                        journalId: _valueJournalId);
                                    print(loanModel);
                                    controller
                                        .createLoan(loanModel)
                                        .then((value) {
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
                                        Get.snackbar('error maseeg',
                                            'Please check the entries',
                                            titleText: const Text(
                                              'error maseeg',
                                              style: subtitlestyle,
                                            ),
                                            messageText: const Text(
                                              'Please check the entries',
                                              style: subtitlestyle,
                                            ),
                                            duration:
                                                const Duration(seconds: 5),
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: deepPurple);
                                      }
                                    });
                                  }
                                }
                              },
                            )
                    ],
                  ),
                )),
    );
  }

  // Widget popupMenu(List allEmployees) {
  //   return Center(
  //     child: PopupMenuButton(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       itemBuilder: (BuildContext context) {
  //         return allEmployees.map((item) {
  //           return PopupMenuItem<String>(
  //             onTap: () {
  //               setState(() {
  //                 _valueEmployee = item['id'].toString();
  //               });
  //             },
  //             value: item['name'],
  //             child: Text(item['name']),
  //           );
  //         }).toList();
  //       },
  //       onSelected: (String value) {
  //         setState(() {
  //           _selectedEmployee = value;
  //         });
  //       },
  //       child: Container(
  //         margin: const EdgeInsets.all(20),
  //         padding: const EdgeInsets.all(10),
  //         decoration: const BoxDecoration(
  //           border: Border(bottom: BorderSide(color: deepPurple)),
  //         ),
  //         child: Center(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 _selectedEmployee.isEmpty
  //                     ? 'Select Employee'
  //                     : _selectedEmployee,
  //                 style: _selectedEmployee.isEmpty ? subtitlestyle : focusstyle,
  //               ),
  //               const Icon(Icons.arrow_drop_down),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget popupMenujournal(List allgetJournalIds) {
    return Center(
      child: PopupMenuButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        itemBuilder: (BuildContext context) {
          return allgetJournalIds.map((item) {
            return PopupMenuItem<String>(
              value: item['type'],
              onTap: () {
                setState(() {
                  _valueJournalId = item['id'].toString();
                });
              },
              child: Text(item['type'].toString()),
            );
          }).toList();
        },
        onSelected: (String value) {
          setState(() {
            _selectedJournalId = value;
          });
        },
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: deepPurple)),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedJournalId.isEmpty
                      ? 'Select Journal'
                      : _selectedJournalId,
                  style:
                      _selectedJournalId.isEmpty ? subtitlestyle : focusstyle,
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
