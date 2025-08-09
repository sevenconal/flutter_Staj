import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_word_app/models/word.dart';
import 'package:flutter_word_app/services/isar_service.dart';
import 'package:image_picker/image_picker.dart';

class AddWordScreen extends StatefulWidget {
  final IsarService isarService;
  final VoidCallback onSave;
  final Word? wordToEdit;
  const AddWordScreen(
      {super.key,
      required this.isarService,
      required this.onSave,
      this.wordToEdit});

  @override
  State<AddWordScreen> createState() => _AddWordScreenState();
}

class _AddWordScreenState extends State<AddWordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _englishController = TextEditingController();
  final _turkishController = TextEditingController();
  final _storyController = TextEditingController();
  String _selectedWordType = "Noun";
  bool _isLearned = false;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  List<String> wordType = [
    'Noun',
    'Adjective',
    'Verb',
    'Adverb',
    'Phrasal Verb',
    'Idiom'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.wordToEdit != null) {
      var guncellenecekKelime = widget.wordToEdit;
      _englishController.text = guncellenecekKelime!.englishWord;
      _turkishController.text = guncellenecekKelime.turkishWord;
      _storyController.text = guncellenecekKelime.story!;
      _selectedWordType = guncellenecekKelime.wordType;
      _isLearned = guncellenecekKelime.isLearned;
    }
  }

  Future<void> _saveWord() async {
    if (_formKey.currentState!.validate()) {
      var englishWord = _englishController.text;
      var turkishWord = _turkishController.text;
      var story = _storyController.text;
      var kelime = Word(
        englishWord: englishWord,
        turkishWord: turkishWord,
        wordType: _selectedWordType,
        isLearned: _isLearned,
        story: story,
      );

      if (widget.wordToEdit == null) {
        kelime.imageBytes =
            _imageFile != null ? await _imageFile!.readAsBytes() : null;
        await widget.isarService.saveWord(kelime);
      } else {
        kelime.id = widget.wordToEdit!.id;
        kelime.imageBytes = _imageFile != null
            ? await _imageFile!.readAsBytes()
            : widget.wordToEdit?.imageBytes;
        await widget.isarService.updateWord(kelime);
      }

      widget.onSave();
    }
  }

  @override
  void dispose() {
    _englishController.dispose();
    _turkishController.dispose();
    _storyController.dispose();
    super.dispose();
  }

  Future<void> _resimSec() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter english word";
                  }
                  return null;
                },
                controller: _englishController,
                decoration: const InputDecoration(
                  labelText: 'English Word',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _turkishController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter turkish word";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Turkish Word',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownButtonFormField<String>(
                value: _selectedWordType,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Word Type'),
                ),
                items: wordType.map(
                  (e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedWordType = value!;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _storyController,
                decoration: const InputDecoration(
                    labelText: 'Word Story', border: OutlineInputBorder()),
                maxLines: 3,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  const Text("Learned"),
                  Switch(
                    value: _isLearned,
                    onChanged: (value) {
                      setState(() {
                        _isLearned = !_isLearned;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                onPressed: _resimSec,
                label: const Text("Add Image"),
                icon: const Icon(Icons.image),
              ),
              const SizedBox(
                height: 8,
              ),
              if (_imageFile != null ||
                  widget.wordToEdit?.imageBytes != null) ...[
                if (_imageFile != null)
                  Image.file(_imageFile!, height: 150, fit: BoxFit.cover)
                else if (widget.wordToEdit?.imageBytes != null)
                  Image.memory(
                      Uint8List.fromList(widget.wordToEdit!.imageBytes!),
                      height: 150,
                      fit: BoxFit.cover),
              ],
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: _saveWord,
                child: widget.wordToEdit == null
                    ? const Text("Save Word")
                    : const Text("Update Word"),
              ),
            ],
          )),
    );
  }
}
