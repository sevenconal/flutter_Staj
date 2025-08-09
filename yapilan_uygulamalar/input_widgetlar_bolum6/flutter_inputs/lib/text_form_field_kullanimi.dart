import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class TextFormFieldKullanimi extends StatefulWidget {
  const TextFormFieldKullanimi({super.key});

  @override
  State<TextFormFieldKullanimi> createState() => _TextFormFieldKullanimiState();
}

class _TextFormFieldKullanimiState extends State<TextFormFieldKullanimi> {
  final _formKey = GlobalKey<FormState>();
  String _userName = '', _email = '', _password = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        autovalidateMode: AutovalidateMode.disabled,
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.length < 6) {
                  return 'user name en az 6 karakter olmalı';
                } else {
                  return null;
                }
              },
              onSaved: (newValue) {
                _userName = newValue!;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'Username giriniz'),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              onSaved: (newValue) {
                _email = newValue!;
              },
              keyboardType: TextInputType.emailAddress,
              // autovalidateMode: AutovalidateMode.onUnfocus,
              validator: (value) {
                if (!EmailValidator.validate(value!)) {
                  return 'geçerli bir mail giriniz';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Email giriniz'),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              // autovalidateMode: AutovalidateMode.onUnfocus,
              validator: (value) {
                if (value!.length < 6) {
                  return 'şifre 6 karakterden fazla olmalı';
                } else {
                  return null;
                }
              },
              onSaved: (newValue) {
                _password = newValue!;
              },
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Şifre',
                  hintText: 'Şifre giriniz'),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                  },
                  child: const Text('Temizle'),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    bool sonuc = _formKey.currentState!.validate();
                    if (sonuc) {
                      _formKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Username:$_userName Email:$_email '),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Tüm veriler validate olmalı'),
                        ),
                      );
                    }
                  },
                  child: const Text('Kaydet'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
