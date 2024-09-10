import 'package:flutter/material.dart';

class inactiveButton extends StatefulWidget {
  final String Text;

  const inactiveButton({super.key, required this.Text});

  @override
  State<inactiveButton> createState() => _inactiveButton();
}

class _inactiveButton extends State<inactiveButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            width: double.infinity,
            child: Align(
                widthFactor: double.infinity,
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: (
                              // _nameController.text.isNotEmpty
                              //   ? Color(0xffF7D15E)
                              //   :

                              Color(0xffF7D15E).withOpacity(0.4))),
                      onPressed: () => print(""),
                      child: Text(
                        widget.Text,
                        style: TextStyle(
                          color: Color(0xff242935),
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                ))));
    // )
  }
}
