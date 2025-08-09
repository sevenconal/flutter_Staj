import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimasyonController extends GetxController {
  final containerWidth = 100.0.obs;
  final containerHeight = 100.0.obs;
  final containerColor = Colors.blue.obs;
  final containerRadius = 8.0.obs;
  final containerOpacity = 1.0.obs;

  void changeOpacity() {
    containerOpacity.value = containerOpacity.value == 1.0 ? 0.3 : 1.0;
  }

  void boyutDegis() {
    containerWidth.value = containerWidth.value == 100.0 ? 200.0 : 100.0;
    containerHeight.value = containerHeight.value == 100.0 ? 200.0 : 100.0;
  }

  void sekilDegistir() {
    containerRadius.value = containerRadius.value == 8.0 ? 100.0 : 8.0;
  }

  void renkDegistir() {
    containerColor.value =
        containerColor.value == Colors.blue ? Colors.red : Colors.blue;
  }

  void animasyonlariSifirla() {
    containerWidth.value = 100.0;
    containerHeight.value = 100.0;
    containerRadius.value = 8.0;
    containerColor.value = Colors.blue;
    containerOpacity.value = 1.0;
  }
}
