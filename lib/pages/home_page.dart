import 'package:flutter/material.dart';
import 'package:habbit/components/habit_tile.dart';
import 'package:habbit/components/monthly_summary.dart';
import 'package:habbit/components/my_alert_box.dart';
import 'package:habbit/data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../components/my_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // data structure for today's list
  Habitdatabase db = Habitdatabase();
  final _myBox = Hive.box("Habit_Database");
  @override
  void initState() {
    // if there is no current data habit list , then it is the 1st time ever opening the app
    // then create the defalt data
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefultData();
    }
    // there already exist data , this is not the first time
    else {
      db.loadData();
    }
    // update the databse
    db.updateDatabase();

    super.initState();
  }

  // bool to control the habit is completed or not
  bool habitCompleted = false;
  // checkbox was tapped
  void checkboxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value!;
    });
    db.updateDatabase();
  }

  // create a new habit
  final _newhabitNamecontroller = TextEditingController();
  // create a new habbit
  void createNewhabit() {
    // show aler dialog for user to enter the new habit details
    showDialog(
        context: context,
        builder: (context) {
          return MyalertBox(
            controller: _newhabitNamecontroller,
            onsave: saveNewHabit,
            hintext: 'Enter a habit name..',
            onCancel: cancelDialogBox,
          );
        });
  }

  // save a new habit
  void saveNewHabit() {
    setState(() {
      db.todaysHabitList.add([_newhabitNamecontroller.text, false]);
    });

    // clear texfield
    _newhabitNamecontroller.clear();
    // pop dialog box
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // cancel a new habit
  void cancelDialogBox() {
    // clear texfield
    _newhabitNamecontroller.clear();
    // pop dialog box
    Navigator.of(context).pop();
  }

  // open habit  settings to edit
  void openHabitSettings(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return MyalertBox(
            controller: _newhabitNamecontroller,
            onsave: () => saveExistingHabit(index),
            hintext: db.todaysHabitList[index][0],
            onCancel: cancelDialogBox,
          );
        });
  }
  // save exiting habit with a new name

  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newhabitNamecontroller.text;
    });
    _newhabitNamecontroller.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  // delete a habit
  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 217, 211, 211),
        floatingActionButton: Myfloatingactionbutoon(
          onPressed: createNewhabit,
        ),
        body: ListView(
          children: [
            // monthly salary heatmap
            MonthlySummary(
              datasets: db.heatMapDataset,
             startDate: _myBox.get("START_DATE")),

            // list of habbits
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: db.todaysHabitList.length,
                itemBuilder: (context, index) {
                  return HabitTile(
                    habitName: db.todaysHabitList[index][0],
                    habitCompleted: db.todaysHabitList[index][1],
                    onChanged: (value) => checkboxTapped(value, index),
                    settingsTapped: (context) => openHabitSettings(index),
                    deleteTapped: (context) => deleteHabit(index),
                  );
                })
          ],
        ));
  }
}
