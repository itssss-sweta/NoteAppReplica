import 'package:flutter/material.dart';
import './screen/home.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/adapters.dart';
import '../screen/addnote.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize hive
  await Hive.initFlutter();
  //Hive.registerAdapter(NoteData());
  //open a hive box
  await Hive.openBox('note_database');
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
