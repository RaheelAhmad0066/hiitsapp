import 'package:flutter/material.dart';

class borderButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const borderButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  State<borderButton> createState() => _borderButton();
}

class _borderButton extends State<borderButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(15),
            side: const BorderSide(width: 1.0, color: Color(0xffF7D15E)),
            backgroundColor: Color(0xFF252835),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Text(
            widget.buttonText,
            style: TextStyle(
                color: Color(0xffF7D15E),
                fontFamily: "InterBold",
                fontSize: 15),
          )),
    );
  }
}
