import 'package:flutter/material.dart';

class bottomButton extends StatefulWidget {
  final String Text;
  final VoidCallback onPressed;

  const bottomButton({super.key, required this.Text, required this.onPressed});

  @override
  State<bottomButton> createState() => _bottomButton();
}

class _bottomButton extends State<bottomButton> {
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
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: (Color(0xffF7D15E))),
                    onPressed: widget.onPressed,
                    child: Text(
                      widget.Text,
                      style: TextStyle(
                        color: Color(0xff242935),
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              ))),
    );
  }
}
