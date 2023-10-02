import 'package:flutter/material.dart';
import 'package:hr_mobile/string/colors.dart';
import 'package:hr_mobile/string/string.dart';
import 'package:hr_mobile/view/employeeDetails.dart';
import 'package:hr_mobile/widget/button.dart';
import 'package:hr_mobile/widget/menu_items.dart';
import 'package:hr_mobile/widget/textField.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import '../controller/loan_controller.dart';
import '../model/employee_model.dart';

class AccountStatementUser extends StatefulWidget {
  const AccountStatementUser({super.key});

  @override
  State<AccountStatementUser> createState() => _AccountStatementUserState();
}

class _AccountStatementUserState extends State<AccountStatementUser> {
  final LoanController controller = Get.put(LoanController());
  final TextEditingController mounth = TextEditingController();
  final TextEditingController year = TextEditingController();
  List searchItems = [];
  List searchmonths = [];
  List searchYears = [];
  bool flage = false;

  getmonths() async {
    var getmonths = await controller.getMonthSelection();
    searchmonths = getmonths;
  }

  getYears() async {
    var getYears = await controller.getYearSelection();
    searchYears = getYears;
  }

  // _selectDate(BuildContext context, TextEditingController dataTime) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now().subtract(const Duration(days: 365)),
  //     lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
  //   );

  //   if (pickedDate != null) {
  //     setState(() {
  //       dataTime.text = pickedDate.toString().substring(0, 11);
  //     });
  //   }
  //   if (mounth.text.isNotEmpty) {
  //     mounth.text = pickedDate.toString().substring(5, 7);
  //   } else if (year.text.isNotEmpty) {
  //     year.text = pickedDate.toString().substring(0, 4);
  //     //
  //   }
  // }

  // getEmployees(String mounth, String year) async {
  //   setState(() {
  //     flage = true;
  //   });
  //   var getItems = await controller.accountStatementUser(mounth, year);
  //   searchItems = getItems;
  //   print(searchItems[0]["detail_ids"]);
  //   setState(() {
  //     flage = false;
  //   });
  //   print("searchItems");
  //   print(searchItems);
  // }

  getEmployees() async {
    setState(() {
      flage = true;
    });
    var getItems = await controller.accountStatementUser();
    searchItems = getItems;
    setState(() {
      flage = false;
    });
  }

  @override
  void initState() {
    getmonths();
    getYears();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Account Statement User"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Builder(builder: (mountcontext) {
                    return ContainerTextField(
                      controller: mounth,
                      readOnly: true,
                      prefixIcon: const Icon(Icons.date_range_outlined),
                      hintText: 'Mounth',
                      labelText: 'Mounth',
                      onTap: () {
                        showPopover(
                            direction: PopoverDirection.bottom,
                            context: mountcontext,
                            height: 400,
                            width: 250,
                            bodyBuilder: (contex) => MenuItems(
                                  children: searchmonths
                                      .map((item) => Container(
                                            padding: const EdgeInsets.all(5),
                                            child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    mounth.text = item[0];
                                                  });
                                                },
                                                child:
                                                    Text(item[0].toString())),
                                          ))
                                      .toList(),
                                ));
                      },
                    );
                  }),
                ),
                Expanded(
                  child: Builder(builder: (yearcontext) {
                    return ContainerTextField(
                      controller: year,
                      readOnly: true,
                      prefixIcon: const Icon(Icons.date_range_outlined),
                      hintText: 'Year',
                      labelText: 'Year',
                      onTap: () {
                        showPopover(
                            direction: PopoverDirection.bottom,
                            context: yearcontext,
                            height: 400,
                            width: 250,
                            bodyBuilder: (contex) => MenuItems(
                                  children: searchYears
                                      .map((item) => Container(
                                            padding: const EdgeInsets.all(10),
                                            child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    year.text = item[0];
                                                  });
                                                },
                                                child:
                                                    Text(item[0].toString())),
                                          ))
                                      .toList(),
                                ));
                      },
                    );
                  }),
                ),
              ],
            ),
            ButtonElevated(
              text: 'Search ',
              minimumSize: 0,
              onPressed: () {
                getEmployees();
              },
            ),
            flage == true
                ? const CircularProgressIndicator()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    primary: true,
                    shrinkWrap: true,
                    itemCount: searchItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      List detailIds = searchItems[0]["detail_ids"];
                      return detailIds.isEmpty
                          ? const SizedBox(
                              height: 20,
                              child: Center(
                                child: Text(
                                  "No detail In This employe",
                                  style: subtitlestyle,
                                ),
                              ),
                            )
                          : FutureBuilder(
                              future: controller.employeeDetails(
                                  detailId: searchItems[index]["detail_ids"][0],
                                  mounth: mounth.text,
                                  year: year.text),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator(); // Show a loading indicator while waiting for data
                                } else if (snapshot.hasError) {
                                  return Text(
                                      'Error: ${snapshot.error}'); // Show an error message if an error occurred
                                } else {
                                  return snapshot.data!.length == 0
                                      ? const SizedBox(
                                          height: 20,
                                          child: Center(
                                            child: Text(
                                              "No Data In This mounth",
                                              style: subtitlestyle,
                                            ),
                                          ),
                                        )
                                      : ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          primary: true,
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (BuildContext context,
                                              int detailsindex) {
                                            var employeesdetail =
                                                EmployeesdetailModel.fromJson(
                                                    snapshot.data[detailsindex]
                                                        as Map<String,
                                                            dynamic>);
                                            return Card(
                                              child: ExpansionTile(
                                                title: ListTile(
                                                  leading: Builder(
                                                      builder: (contex) {
                                                    return IconButton(
                                                        onPressed: () {
                                                          showPopover(
                                                              context: contex,
                                                              height: 150,
                                                              width: 200,
                                                              bodyBuilder:
                                                                  (contex) =>
                                                                      MenuItems(
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              // Get.to(() => EmployeeDetails(
                                                                              //       employeesdetail: employeesdetail,
                                                                              //     ));
                                                                            },
                                                                            child:
                                                                                const ListTile(
                                                                              title: Text("Detail"),
                                                                              leading: Icon(
                                                                                Icons.visibility,
                                                                                color: deepPurple,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              // Get.to(() => EmployeeDetails(
                                                                              //       employeesdetail: employeesdetail,
                                                                              //     ));
                                                                            },
                                                                            child:
                                                                                const ListTile(
                                                                              title: Text("Delete"),
                                                                              leading: Icon(
                                                                                Icons.delete,
                                                                                color: red,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ));
                                                          // showPopupMenu(context,employeesdetail);
                                                        },
                                                        icon: const Icon(
                                                            Icons.menu));
                                                  }),
                                                  title: Row(
                                                    children: [
                                                      Text(
                                                        'netSalary ${employeesdetail.netSalary.toString()}',
                                                        style: focusstyle,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                          'year ${employeesdetail.year}',
                                                          style: subtitlestyle),
                                                    ],
                                                  ),
                                                  subtitle: Text(
                                                      'mounth ${employeesdetail.mounth}',
                                                      style: subtitlestyle),
                                                ),
                                                children: <Widget>[
                                                  EmployeeDetails(
                                                    employeesdetail:
                                                        employeesdetail,
                                                  )
                                                ],
                                              ),
                                            );
                                          });

                                  // Show the data if available
                                }
                              },
                            );
                    })
          ],
        ),
      ),
    ));
  }

  void showPopupMenu(
      BuildContext context, EmployeesdetailModel employeesdetail) async {
    var popupMenuemployee = [
      {
        "name": GestureDetector(
          onTap: () {
            Get.to(() => EmployeeDetails(
                  employeesdetail: employeesdetail,
                ));
          },
          child: const Text("Detail"),
        ),
        "icon": GestureDetector(
          onTap: () {
            Get.to(() => EmployeeDetails(
                  employeesdetail: employeesdetail,
                ));
          },
          child: const Icon(Icons.visibility),
        )
        // Icons.visibility
      },
      {
        "name": GestureDetector(
          onTap: () {
            Get.to(() => EmployeeDetails(
                  employeesdetail: employeesdetail,
                ));
          },
          child: const Text("Delet"),
        ),
        "icon": GestureDetector(
          onTap: () {
            Get.to(() => EmployeeDetails(
                  employeesdetail: employeesdetail,
                ));
          },
          child: const Icon(Icons.delete),
        )
      }
    ];
    await showMenu(
        context: context,
        position: const RelativeRect.fromLTRB(0, 0, 0, 0),
        items: popupMenuemployee.map((item) {
          return PopupMenuItem(
              value: item['name'].toString(),
              child: ListTile(
                title: item['name'] as Widget,
                leading: item['icon'] as Widget,
              ));
        }).toList());
  }
}
