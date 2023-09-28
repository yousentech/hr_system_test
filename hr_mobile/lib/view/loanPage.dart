import 'package:flutter/material.dart';
import 'package:hr_mobile/widget/textField.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController date = TextEditingController();
  final TextEditingController amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:const Text("LoanPage"),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [

              ContainerTextField(
                controller: date,
                prefixIcon:const Icon(Icons.date_range_outlined),
                hintText: 'Date',
                labelText: 'Date',
              ),
              ContainerTextField(
                controller: amount,
                prefixIcon:const Icon(Icons.monetization_on_outlined),
                hintText: 'amount',
                labelText: 'amount',
              ),
            ],
          ),
        )),
    );
  }
}
