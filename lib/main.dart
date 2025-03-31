import 'dart:io';

import 'package:flutter/material.dart'; // SQL- Tables, Firebase- Collections,Hive-boxes
import 'package:flutter_hive_db/homescreen.dart';
import 'package:flutter_hive_db/todo.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Directory directory = await getApplicationDocumentsDirectory();
//   Hive.init(directory.path);

// // Register the adapter
//   Hive.registerAdapter(TodoAdapter());
//   // open a new box with todo data type
//   await Hive.openBox<Todo>('todo');
//   await Hive.openBox('friend');
//   runApp(const MyApp());
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter(TodoAdapter());

  // // 🚨 DELETE OLD DATABASE 🚨
  // await Hive.deleteBoxFromDisk('todo');

  await Hive.openBox<Todo>('todo');
  
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}
