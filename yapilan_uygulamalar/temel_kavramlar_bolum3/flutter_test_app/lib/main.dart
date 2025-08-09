import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    var myPinkContainer = Container(
      color: Colors.pink,
      height: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          myContainer(),
          myContainer(),
        ],
      ),
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Test App'),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                color: Colors.red,
                width: 50,
                height: 300,
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                color: Colors.green,
                width: 50,
                height: 300,
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint("Buton Tıklandı");
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.add_a_photo_outlined),
        ),
      ),
    );
  }

  List<Widget> get expandedAnlatimi {
    return [
      Expanded(
        flex: 4,
        child: Container(
          height: 150,
          color: Colors.red,
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
          width: 300,
          height: 150,
          color: Colors.yellow,
        ),
      ),
      Expanded(
        flex: 4,
        child: Container(
          width: 50,
          height: 150,
          color: Colors.pink,
        ),
      ),
    ];
  }

  Column myMainColumn(Container myPinkContainer) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [myPinkContainer, myPinkContainer],
    );
  }

  Container myContainer() {
    return Container(
      color: Colors.amber,
      height: 150,
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Container(
        width: 100,
        alignment: Alignment.center,
        height: 100,
        color: Colors.red,
        child: const Text('Hello World'),
      ),
    );
  }
}
