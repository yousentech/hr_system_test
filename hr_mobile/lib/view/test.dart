import 'package:flutter/material.dart';
import 'package:get/get.dart';



class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('GetX Example'),
        ),
        body: Center(
          child: GetBuilder<CounterController>(
            init: CounterController(),
            builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Count: ${controller.count.toString()}'),
                  ElevatedButton(
                    onPressed: () => controller.increment(),
                    child: Text('Increment'),
                  ),
                ],
              );
            },
          ),
        ),
      
    );
  }
}

class CounterController extends GetxController {
  var count = 0;

  void increment() {
    count++;
    update();
  }
}