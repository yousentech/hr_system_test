class OffdaysModel {
  final String employeeId;
  final String numberOfDays;
  final String date;
  OffdaysModel({
    required this.employeeId,
    required this.numberOfDays,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    var month = date.substring(5, 7);
    final Map<String, dynamic> json = Map<String, dynamic>();
    json['employee_id'] = employeeId;
    json['number_of_days'] = numberOfDays;
    json['month'] =
        month[0] == "0" ? date.substring(6, 7) : date.substring(5, 7);
    json['year'] = date.substring(0, 4); 
    return json;
  }
}
