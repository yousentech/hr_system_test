import 'package:flutter/material.dart';
import 'package:hr_mobile/controller/employee_controller.dart';
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

class AllEmployees extends StatefulWidget {
  const AllEmployees({super.key});

  @override
  State<AllEmployees> createState() => _AllEmployeesState();
}

class _AllEmployeesState extends State<AllEmployees> {
  final LoanController controller = Get.put(LoanController());
  final EmployeeController employeecontroller = Get.put(EmployeeController());
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

  getEmployees({
    required String year,
    required String mounth,
  }) async {
    setState(() {
      flage = true;
    });
    var getItems = await employeecontroller.allemployeesDetails(
        mounth: mounth, year: year);
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
        title: const Text("All Employees Trancation"),
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
                getEmployees(mounth: mounth.text, year: year.text);
              },
            ),
            flage == true
                ? const CircularProgressIndicator()
                : FutureBuilder(
                    future: employeecontroller.allemployeesDetails(
                        mounth: mounth.text, year: year.text),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                                physics: const BouncingScrollPhysics(),
                                primary: true,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder:
                                    (BuildContext context, int detailsindex) {
                                  var employeesdetail =
                                      EmployeesdetailModel.fromJson(
                                          snapshot.data[detailsindex]
                                              as Map<String, dynamic>);
                                  return Card(
                                    child: ExpansionTile(
                                      title: ListTile(
                                        leading: Builder(builder: (contex) {
                                          return IconButton(
                                              onPressed: () {
                                                showPopover(
                                                    context: contex,
                                                    height: 150,
                                                    width: 200,
                                                    bodyBuilder: (contex) =>
                                                        MenuItems(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                // Get.to(() => EmployeeDetails(
                                                                //       employeesdetail: employeesdetail,
                                                                //     ));
                                                              },
                                                              child:
                                                                  const ListTile(
                                                                title: Text(
                                                                    "Detail"),
                                                                leading: Icon(
                                                                  Icons
                                                                      .visibility,
                                                                  color:
                                                                      deepPurple,
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                // Get.to(() => EmployeeDetails(
                                                                //       employeesdetail: employeesdetail,
                                                                //     ));
                                                              },
                                                              child:
                                                                  const ListTile(
                                                                title: Text(
                                                                    "Delete"),
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
                                              icon: const Icon(Icons.menu));
                                        }),
                                        title: Row(
                                          children: [
                                            Text(
                                              employeesdetail.empMasterId[1].toString(),
                                              style: focusstyle,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text('year ${employeesdetail.year}',
                                                style: subtitlestyle),
                                          ],
                                        ),
                                        subtitle: Text(
                                            'mounth ${employeesdetail.mounth}',
                                            style: subtitlestyle),
                                      ),
                                      children: <Widget>[
                                        EmployeeDetails(
                                          employeesdetail: employeesdetail,
                                        )
                                      ],
                                    ),
                                  );
                                });

                        // Show the data if available
                      }
                    },
                  )
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
