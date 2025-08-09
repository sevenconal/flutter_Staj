import 'package:flutter/material.dart';
import 'package:flutter_gex_dersleri/second/second_controller.dart';
import 'package:get/get.dart';

class SecondPage extends GetView<SecondController> {
  SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(()=>Text(controller.name.value)),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        
        controller.degistir();
      }),
    );
  }
}
