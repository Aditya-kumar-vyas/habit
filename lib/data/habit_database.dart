import 'package:habbit/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

// reference you box

final _myBox = Hive.box("Habit_database");

class Habitdatabase {
  List todaysHabitList = [];
  Map<DateTime, int> heatMapDataset = {};

  // create initial defalut data
  void createDefultData() {
    todaysHabitList = [
      ["Code", false],
      ["Play", false],
    ];
    _myBox.put("START_DATE", todaysDateFormatted());
  }

  // load data if it already exist

  void loadData() {
    // if it's a new day , get habit list from database
    if (_myBox.get(todaysDateFormatted()) == null) {
      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");
      // set all habit complete to false since its a new day
      for (int i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][1] = false;
      }
    }

    // if its not a new day , load today's list
    else {
      todaysHabitList = _myBox.get(todaysDateFormatted());
    }
  }
  // update database

  void updateDatabase() {
    // update today's entry
    _myBox.put(todaysDateFormatted(), todaysHabitList);
    // update universal habit list in case it changed (new habit , edit habit , delete habit)
    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);
    // calculate habit complete percentages for each day
    calculateHabitPercentages();

    // load heat map
    loadHeatMap();
  }

  void calculateHabitPercentages() {
    int cnt = 0;
    for (int i = 0; i < todaysHabitList.length; i++) {
      if (todaysHabitList[i][1] == true) {
        cnt++;
      }
    }
    String percent = todaysHabitList.isEmpty
        ? '0.0'
        : (cnt / todaysHabitList.length).toStringAsFixed(1);
    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatMap() 
  {
      DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

      // count the number of days to load

      int daysinbetween = DateTime.now().difference(startDate).inDays;

      // go from start date to today and add each percentage to the dataset 
      // "PERCENTAGE_SUMMARY_YYYYMMDD" will be the key in the database
      for(int i =0 ; i<daysinbetween+1 ; i++)
      {
          String yyyymmdd = convertDateTimeToString(
            startDate.add(Duration(days : i)),
          );

          double strength = double.parse(
             _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0" ,
          );
          // split the datetime up like below so it dosent worry about hours/mins/sec

          // year
          int year = startDate.add(Duration(days: i)).year;
          // month
            int month = startDate.add(Duration(days: i)).month;
          // day
            int day = startDate.add(Duration(days: i)).day;

            final percentForEachDay = <DateTime , int> {
               DateTime(year , month, day) : (10 * strength).toInt()
            };

            heatMapDataset.addEntries(percentForEachDay.entries);
            print(heatMapDataset);
      }
  }
}
