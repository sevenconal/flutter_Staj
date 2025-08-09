import 'package:flutter/material.dart';
import 'package:flutter_word_app/models/word.dart';
import 'package:flutter_word_app/screens/add_word_screen.dart';
import 'package:flutter_word_app/screens/word_list_screen.dart';
import 'package:flutter_word_app/services/isar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isarService = IsarService();
  try {
    await isarService.init();

    // Word eklenecekKelime = Word(englishWord: "garden", turkishWord: "bahçe", wordType: "noun");
    // await isarService.saveWord(eklenecekKelime);
    final words = await isarService.getAllWords();
    debugPrint(words.toString());
  } catch (e) {
    debugPrint("Main dartda isar service baslatılamadı $e");
  }
  runApp(
    MyApp(
      isarService: isarService,
    ),
  );
}

class MyApp extends StatelessWidget {
  final IsarService isarService;
  const MyApp({super.key, required this.isarService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(
        isarService: isarService,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final IsarService isarService;
  const MainPage({super.key, required this.isarService});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedScreen = 0;
  Word? _wordToEdit;

  void _editWord(Word guncellenecekKelime) {
    setState(() {
      _selectedScreen = 1;
      _wordToEdit = guncellenecekKelime;
    });
  }

  List<Widget> getScreens() {
    return [
      WordList(
        isarService: widget.isarService,
        onEditWord: _editWord,
      ),
      AddWordScreen(
          isarService: widget.isarService,
          wordToEdit: _wordToEdit,
          onSave: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Kelime kaydedildi"),
              ),
            );
            setState(() {
              _selectedScreen = 0;
              _wordToEdit = null;
            });
          }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kelimelerim"),
      ),
      body: getScreens()[_selectedScreen],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedScreen,
        destinations: [
          const NavigationDestination(
              icon: Icon(Icons.list_alt), label: "Kelimeler"),
          NavigationDestination(
              icon: const Icon(Icons.add_circle_outline),
              label: _wordToEdit == null ? "Ekle" : 'Güncelle'),
        ],
        onDestinationSelected: (value) {
          setState(() {
            _selectedScreen = value;
            if (_selectedScreen == 0) {
              _wordToEdit = null;
            }
          });
        },
      ),
    );
  }
}
