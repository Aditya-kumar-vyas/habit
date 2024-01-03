import 'package:flutter/material.dart';
import 'package:habbit/components/habit_tile.dart';
import 'package:habbit/components/new_habit_box.dart';

import '../components/my_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // data structure for today's list
  List todaysHabitList = [
    // [habbit name , habbit completed]
  
  ];
  // bool to control the habit is completed or not
  bool habitCompleted = false;
  // checkbox was tapped
  void checkboxTapped(bool? value, int index) {
    setState(() {
      todaysHabitList[index][1] = value!;
    });
  }

  // create a new habit
  final _newhabitNamecontroller = TextEditingController();
  // create a new habbit
  void createNewhabit() {
    // show aler dialog for user to enter the new habit details
    showDialog(
        context: context,
        builder: (context) {
          return Enternewhabitbox(
            controller: _newhabitNamecontroller,
            onsave: saveNewHabit,
            onCancel: cancelNewhabit,
          );
        });
  }

  // save a new habit
  void saveNewHabit() {
     
     setState(() {
        todaysHabitList.add([_newhabitNamecontroller.text , false]);
     });
     
    


     
     
     // clear texfield
    _newhabitNamecontroller.clear();
    // pop dialog box
    Navigator.of(context).pop();
  }
  // cancel a new habit
  void cancelNewhabit() {
    // clear texfield
    _newhabitNamecontroller.clear();
    // pop dialog box
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        floatingActionButton: Myfloatingactionbutoon(
          onPressed: createNewhabit,
        ),
        body: ListView.builder(
            itemCount: todaysHabitList.length,
            itemBuilder: (context, index) {
              return HabitTile(
                habitName: todaysHabitList[index][0],
                habitCompleted: todaysHabitList[index][1],
                onChanged: (value) => checkboxTapped(value, index),
              );
            }));
  }
}
