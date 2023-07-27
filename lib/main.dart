import 'package:flutter/material.dart';
import 'package:noteappreplica/function/addnote.dart';
import 'package:provider/provider.dart';
import 'package:noteappreplica/screen/home.dart';

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
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}
