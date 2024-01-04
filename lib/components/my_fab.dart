import 'package:flutter/material.dart';
class Myfloatingactionbutoon extends StatelessWidget {
  final Function()? onPressed;
  const Myfloatingactionbutoon({super.key,
  required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),

    );
  }
}