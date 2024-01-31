
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/my_fab.dart';
import 'package:habit_tracker/components/new_alert_box.dart';
import 'package:habit_tracker/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ds for today list
  List todayHabitList = [
    // [habitname, habitCompleted]
    ["Morning Run", false],
    ["Read Book", false],
    ["Code", false],
  ];


  // checkedbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todayHabitList[index][1] = value;
    });
  }

  // create a new habit
  final _newHabitNameController = TextEditingController();
  void createNewHabit(){
    // show alert dialog for user to enter the new habit details
    showDialog(
      context: context, 
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save a new habit 
  void saveNewHabit() {
    // add new habit to today's habit list 
    setState(() {
      todayHabitList.add([_newHabitNameController.text, false]);
    });

    // clear textfield
    _newHabitNameController.clear();
    // pop dialog box
    Navigator.of(context).pop();
  }

  // cancel a habit
  void cancelDialogBox() {
    // clear textfield 
    _newHabitNameController.clear();
    // pop dialog box 
    Navigator.of(context).pop();
  }

  // open habit settings to edit
  void openHabitSettings(int index) {
    showDialog(
      context: context, 
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        ); 
      },
    );
  }

    // save existing habit with a new name
    void saveExistingHabit(int index){
      setState(() {
        todayHabitList[index][0] = _newHabitNameController.text;
      });
    }

    // delete habit
    void deleteHabit(int index) {
      setState(() {
        todayHabitList.removeAt(index);
      });
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Center(child: CupertinoSwitch(
          value: Provider.of<ThemeProvider>(context).isDarkMode, 
          onChanged: (value) => 
          Provider.of<ThemeProvider>(context, listen: false)
          .toggleTheme(),
        ),
      ),
     ),
     floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
     body: ListView.builder(
      itemCount: todayHabitList.length,
      itemBuilder: (context, index) {
        return HabitTile(
          habitCompleted: todayHabitList[index][1], 
          habitname: todayHabitList[index][0], 
          onChanged: (value) => checkBoxTapped(value, index),
          settingsTapped: (context) => openHabitSettings(index),
          deleteTapped: (context) => deleteHabit(index),
        );
      },
     ),
    );
  }
}