import 'package:flutter/material.dart';
import 'package:flutter_gex_dersleri/animasyonlar/animasyon_binding.dart';
import 'package:flutter_gex_dersleri/animasyonlar/animasyon_page.dart';
import 'package:flutter_gex_dersleri/core/initial_bindings.dart';
import 'package:flutter_gex_dersleri/home_page/home_binding.dart';
import 'package:flutter_gex_dersleri/home_page/home_page.dart';
import 'package:flutter_gex_dersleri/home_page/sayac_controller.dart';
import 'package:flutter_gex_dersleri/home_page/sayi_controller.dart';
import 'package:flutter_gex_dersleri/second/second_binding.dart';
import 'package:flutter_gex_dersleri/second/second_page.dart';
import 'package:flutter_gex_dersleri/splash/splash_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
  //simple state --> setState --> update --> getbuilder
  //reactive --> obx --> getx
  //performance olarak getbuilder < getx < obx widget
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      getPages: [
        GetPage(name: '/splash', page: () => SplashPage()),
        GetPage(
            name: '/home', page: () => MyHomePage(), binding: HomeBinding()),
        GetPage(
            name: '/second',
            page: () => SecondPage(),
            binding: SecondPageBinding()),

             GetPage(
            name: '/animasyon',
            page: () => AnimasyonPage(),
            binding: AnimasyonBinding()),
      ],
      initialRoute: '/splash',
      initialBinding: InitialBindings(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
