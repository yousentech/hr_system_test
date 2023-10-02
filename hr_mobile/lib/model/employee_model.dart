class EmployeesModel {
  final String name;
  final String phone;
  final String workEmail;
  final bool emploCheckbox;
  EmployeesModel({
    required this.name,
    required this.phone,
    required this.workEmail,
    required this.emploCheckbox,
  });

    Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> json = Map<String, dynamic>();
    json['name'] = name;
    json['phone'] = phone;
    json['work_email'] = workEmail;
    json['emplo_checkbox'] =emploCheckbox;
    return json;
  }
}

class EmployeesdetailModel {
  double netSalary;
  double rewards;
  double discount;
  String mounth;
  String year;
  int offDays;
  double loan;
  List empMasterId;
  EmployeesdetailModel({
    required this.netSalary,
    required this.rewards,
    required this.discount,
    required this.mounth,
    required this.year,
    required this.offDays,
    required this.loan,
    required this.empMasterId,
  });

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> json = Map<String, dynamic>();
    json['net_salary'] = netSalary;
    json['rewards'] = rewards;
    json['discount'] = discount;
    json['mounth'] = mounth;
    json['year'] = year;
    json['off_days'] = offDays;
    json['loan'] = loan;
    json['emp_master_id'] = empMasterId;
    return json;
  }

  factory EmployeesdetailModel.fromJson(Map<String, dynamic> json) {
  return EmployeesdetailModel(
    netSalary : json['net_salary'],
    rewards : json['rewards'],
    discount : json['discount'],
    mounth : json['mounth'],
    year : json['year'],
    offDays : json['off_days'],
    loan : json['loan'],
    empMasterId : json['emp_master_id']);
  }
}
