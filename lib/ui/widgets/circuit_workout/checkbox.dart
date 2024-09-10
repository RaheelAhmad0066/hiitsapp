import 'package:flutter/material.dart';

class StatefulCheckbox extends StatefulWidget {
  @override
  _StatefulCheckboxState createState() => _StatefulCheckboxState();
}

class _StatefulCheckboxState extends State<StatefulCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          unselectedWidgetColor: Colors
              .grey), // Set the border color when checkbox is not selected
      child: Checkbox(
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value!;
          });
        },
        activeColor: Color(0xffF7D15E),
        checkColor: Color(0xff43475A),
      ),
    );
  }
}


// #3D4456