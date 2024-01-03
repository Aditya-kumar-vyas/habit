import 'package:flutter/material.dart';
import 'package:habbit/components/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // data structure for today's list

  // bool to control the habit is completed or not
  bool habitCompleted = false;
  // checkbox was tapped
  void checkboxTapped(bool? value) {
    setState(() {
      habitCompleted = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: ListView(children: [
        // habbit tiles
        HabitTile(
          habitName: 'morning run',
          habitCompleted: false,
          onChanged: (value) => checkboxTapped(value),
        ),
        HabitTile(
          habitName: 'morning run',
          habitCompleted: false,
          onChanged: (value) => checkboxTapped(value),
        ),
        HabitTile(
          habitName: 'morning run',
          habitCompleted: false,
          onChanged: (value) => checkboxTapped(value),
        ),
      ]),
    );
  }
}
