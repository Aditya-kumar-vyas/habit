import 'package:flutter/material.dart';
import 'package:habbit/components/habit_tile.dart';
import 'package:habbit/main.dart';
import 'package:habbit/pages/home_page.dart';

void main() {
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
