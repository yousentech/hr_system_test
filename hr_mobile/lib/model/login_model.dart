
class LoginModel {
  final String db;
  final String login;
  final String password;
  LoginModel({
    required this.db,
    required this.login,
    required this.password,
  });

}

// class Autogenerated {
//   String? name;
//   String? email;

//   Autogenerated({this.name, this.email});

//   Autogenerated.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     email = json['email'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['email'] = this.email;
//     return data;
//   }
// }