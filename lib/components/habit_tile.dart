import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String habitname;
  final bool habitCompleted;
  final Function(bool?)? onChanged;

  const HabitTile({
    super.key, 
    required this.habitCompleted,  
    required this.habitname,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // checkbox 
            Checkbox(
              value: habitCompleted, 
              onChanged: onChanged
            ),

            // habit name with increased text size
            Text(habitname,
              style: const TextStyle(fontSize: 18), // Adjust the font size as needed
            ),
          ],
        ),
      ),
    );
  }
}
