import 'package:flutter/material.dart';
import 'package:flutter_gex_dersleri/home_page/sayi_controller.dart';
import 'package:flutter_gex_dersleri/second/second_controller.dart';
import 'package:get/get.dart';

import 'sayac_controller.dart';

class MyHomePage extends StatelessWidget {
  //put ile widget treeye eklenir, find bulunur.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Gext Kullanımı"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed('/second');
                },
                child: Text('Second page git')),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed('/animasyon');
                },
                child: Text('Animasyonlar sayfasına git')),
            GetBuilder<SayacController>(
              builder: (controller) => Text(
                controller.sayac.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const Text(
              'Üretilen Rastgele Sayı',
            ),
            Obx(
              () =>
                  Text(Get.find<SayiController>().randomSayi.value.toString()),
            ),
            Obx(() {
              var c = Get.find<SayiController>();
              return Text(c.randomSayi.value.toString());
            }),
            GetX<SayiController>(
              builder: (controller) =>
                  Text(controller.randomSayi.value.toString()),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MyFloatingActionButton(),
          SizedBox(
            height: 10,
          ),
          RastgeleSayiButon(),
        ],
      ),
    );
  }
}

class RastgeleSayiButon extends GetView<SayiController> {
  const RastgeleSayiButon({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: '1',
      onPressed: () {
        // Get.find<SayiController>().uret();
        controller.uret();
      },
      child: Icon(Icons.refresh),
    );
  }
}

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SayacController controller = Get.find();
    var controller2 = Get.find<SayacController>();
    return GetBuilder<SayacController>(
        builder: (controller) => FloatingActionButton(
              heroTag: '2',
              onPressed: () {
                // controller.arttir();
                // controller2.arttir();
                controller.arttir();
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ));
  }
}
