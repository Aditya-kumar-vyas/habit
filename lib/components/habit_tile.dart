import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;

  const HabitTile(
      {super.key,
      required this.habitName,
      required this.habitCompleted,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(240, 248, 246, 246),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(children: [
          // checkbox
          Checkbox(value: habitCompleted, onChanged: onChanged),
          // habit name
          Text(habitName)
        ]),
      ),
    );
  }
}
