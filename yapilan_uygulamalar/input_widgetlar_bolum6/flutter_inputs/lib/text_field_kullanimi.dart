import 'package:flutter/material.dart';

class TextFieldKullanimi extends StatefulWidget {
  const TextFieldKullanimi({super.key});

  @override
  State<TextFieldKullanimi> createState() => _TextFieldKullanimiState();
}

class _TextFieldKullanimiState extends State<TextFieldKullanimi> {
  // String deger = "";
  int _maxLine = 1;
  late TextEditingController _emailController;
  late FocusNode _emailFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _emailFocusNode.addListener(() {
      setState(() {
        _maxLine = _emailFocusNode.hasFocus ? 3 : 1;
      });
    },);
    _emailController = TextEditingController(text: 'ilk deger');
    _emailController.addListener(
      () {
        setState(() {
          
        });
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _emailController.clear();
            },
            child: const Text('Sıfırla'),
          ),
          TextField(
            focusNode: _emailFocusNode,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.search,
            maxLength: 50,
            maxLines: _maxLine,
            cursorColor: Colors.red,
            readOnly: false,
            onChanged: (value) {
              // debugPrint(value);
              // setState(() {
              //   deger = value;
              // });
            },
            onSubmitted: (value) {
              debugPrint("Submit : $value");
            },
            decoration: InputDecoration(
              // icon: Icon(Icons.add),
              prefixIcon: const Icon(Icons.remove_road),
              suffixIcon: const Icon(Icons.search),
              fillColor: Colors.grey.shade300,
              filled: true,
              hintText: 'Email giriniz',
              labelText: 'Email',
              hintStyle: const TextStyle(color: Colors.orange),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
          ),
          const TextField(
            autofocus: true,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            _emailController.text,
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
