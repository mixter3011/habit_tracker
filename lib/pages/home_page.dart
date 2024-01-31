import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
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
  ];


  // checkedbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todayHabitList[index][1] = value;
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
     body: ListView.builder(
      itemCount: todayHabitList.length,
      itemBuilder: (context, index) {
        return HabitTile(
          habitCompleted: todayHabitList[index][1], 
          habitname: todayHabitList[index][0], 
          onChanged: (value) => checkBoxTapped(value, index),
        );
      },
     ),
    );
  }
}