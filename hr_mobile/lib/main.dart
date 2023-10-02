import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_mobile/view/accountStatement.dart';
import 'package:hr_mobile/view/createEmployee.dart';
import 'package:hr_mobile/view/createoffdays.dart';
import 'package:hr_mobile/view/login.dart';
import 'package:hr_mobile/view/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HR App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        iconTheme:const IconThemeData(
          color: Colors.deepPurple, // Set the default icon color here
        ),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: 
      // const CreateOffdays()
      // Test(),
      const Login(),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:odoo_rpc/odoo_rpc.dart';


// final orpc = OdooClient('http://20.20.20.120:8069');
// void main() async {
//   await orpc.authenticate('mydb', 'admin', 'admin');
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home:const HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//   Future fetchContacts() async{
//     var x=orpc.callKw({
//         'model': 'res.users',
//         'method': 'search_read',
//         'args': [],
//         'kwargs': {
//           'context': {},
//           'domain': [['id', '=', 2]],
//           'fields': ['groups_id'],
//         },
//       });
//       print("x");
//       print(x);
//       print("hhhhhhhhh");
//       var d= await x;
//       print("d");
//       print(d);
      
//     return x;
    
//   }
  


//   Widget buildListItem(Map<String, dynamic> record) {
    
//     return ListTile(
//       title: Text(record['id'].toString()),
//       subtitle: Text(record['id'].toString()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:const Text('Contacts'),
//       ),
//       body: Center(
//         child: FutureBuilder(
//             future: fetchContacts(),
//             // fetchContacts(),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData) {
//               print("snapshot.hasData");
//               print(snapshot.hasData);
//                 return ListView.builder(
//                     itemCount: snapshot.data.length,
//                     itemBuilder: (context, index) {
//                       final record =
//                           snapshot.data[index] as Map<String, dynamic>;
//                       return buildListItem(record);
//                     });
//               } else {
//                 print("snapshot.hasError");
//                 print(snapshot.hasError);
              
//                 if (snapshot.hasError) return const Text('Unable to fetch data');
//                 return const CircularProgressIndicator();
//               }
//             }),
//       ),
//     );
//   }
// }


