import 'package:flutter/material.dart';
class Myfloatingactionbutoon extends StatefulWidget {
  final Function()? onPressed;
  const Myfloatingactionbutoon({super.key,
  required this.onPressed});

  @override
  State<Myfloatingactionbutoon> createState() => _MyfloatingactionbutoonState();
}

class _MyfloatingactionbutoonState extends State<Myfloatingactionbutoon> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){},
      child: const Icon(Icons.add),

    );
  }
}