import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  final Function()? onPressed;

  const MyFloatingActionButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(
        Icons.add,
        color: Colors.white, // Set the color of the Icon to white
      ),
      backgroundColor: Colors.green[500], // Set the color of the button to black
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0), // Adjust the border radius as needed
      ),
    );
  }
}
