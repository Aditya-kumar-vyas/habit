import 'package:flutter/material.dart';
import 'package:habbit/components/habit_tile.dart';
import 'package:habbit/main.dart';
import 'package:habbit/pages/home_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main()async {
  // initialize hive
  await Hive.initFlutter();
  // open a box
  await Hive.openBox("Habit_database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  const  HomePage(),
      theme : ThemeData(primarySwatch : Colors.green )
    );
  }
}
