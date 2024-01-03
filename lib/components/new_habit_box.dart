import 'package:flutter/material.dart';

class Enternewhabitbox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final VoidCallback onsave;
  final VoidCallback onCancel;

  const Enternewhabitbox(
      {super.key,
      required this.controller,
      required this.onsave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 44, 42, 42),
      content: TextField(
        controller: controller,
        style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        decoration: const InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
      ),
      actions: [
        MaterialButton(
          onPressed: onsave,
          child: Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.black,
        ),
        MaterialButton(
          onPressed: onCancel,
          child: Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.black,
        ),
      ],
    );
  }
}
