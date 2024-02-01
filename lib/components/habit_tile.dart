import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatefulWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  const HabitTile({
    Key? key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingsTapped,
    required this.deleteTapped,
  }) : super(key: key);

  @override
  _HabitTileState createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            // settings option
            SlidableAction(
              onPressed: widget.settingsTapped,
              backgroundColor: Colors.grey.shade800,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(12),
            ),

            // delete option
            SlidableAction(
              onPressed: widget.deleteTapped,
              backgroundColor: Colors.red.shade400,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            // Change the color when tapped
            setState(() {
              widget.habitCompleted
                  ? Colors.green
                  : Colors.grey[100];
            });
          },
          child: Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: widget.habitCompleted ? Colors.green : Colors.grey[100],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                // checkbox
                Checkbox(
                  value: widget.habitCompleted,
                  onChanged: (value) {
                    // Invoke the onChanged callback to handle the checkbox state
                    widget.onChanged?.call(value);

                    // Update the tile color immediately when the checkbox is tapped
                    Future.delayed(
                      Duration(milliseconds: 100),
                      () {
                        if (mounted) {
                          // Check if the widget is still mounted before updating the color
                          setState(() {
                            widget.habitCompleted
                                ? Colors.green
                                : Colors.grey[100];
                          });
                        }
                      },
                    );
                  },
                ),

                // habit name and arrow to the right
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.habitName),

                      // arrow towards the right
                      Icon(
                        Icons.arrow_back_outlined,
                        size: 16, // Adjust the size as needed
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
