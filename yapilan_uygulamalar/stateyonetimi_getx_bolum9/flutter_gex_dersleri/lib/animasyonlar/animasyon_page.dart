import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'animasyon_controller.dart';

class AnimasyonPage extends GetView<AnimasyonController> {
  const AnimasyonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animasyonlar"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("AnimatedContainer Örnek"),
              SizedBox(
                height: 8,
              ),
              Obx(
                () => AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  width: controller.containerWidth.value,
                  height: controller.containerHeight.value,
                  decoration: BoxDecoration(
                    color: controller.containerColor.value,
                    borderRadius:
                        BorderRadius.circular(controller.containerRadius.value),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Wrap(
                children: [
                  ElevatedButton(
                    onPressed: controller.boyutDegis,
                    child: Text("Boyut Değiştir"),
                  ),
                  ElevatedButton(
                    onPressed: controller.sekilDegistir,
                    child: Text("Sekil Değiştir"),
                  ),
                  ElevatedButton(
                    onPressed: controller.renkDegistir,
                    child: Text("Renk Değiştir"),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              
              Text("Animated Opacity"),
              Obx(
                () => GestureDetector(
                  onTap: controller.changeOpacity,
                  child: AnimatedOpacity(
                    opacity: controller.containerOpacity.value,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.pink,
                    ),
                    duration: Duration(seconds: 1),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: controller.animasyonlariSifirla,
                  child: Text("Sıfırla"))
            ],
          ),
        ),
      ),
    );
  }
}
