import 'package:flutter/material.dart';
import './screen/home.dart';
import 'package:provider/provider.dart';
import './function/addnote.dart';

void main() async {
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteData(),
      child: MaterialApp(
        title: 'Demo App',
        theme: ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}
