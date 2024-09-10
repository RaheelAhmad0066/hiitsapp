import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class GradientTextWidget extends StatefulWidget {
  final String text;
  const GradientTextWidget({required this.text});

  @override
  GradientTextWidgetClass createState() => GradientTextWidgetClass();
}

class GradientTextWidgetClass extends State<GradientTextWidget> {
  @override
  Widget build(BuildContext context) {
    return GradientText(
      widget.text,
      style: TextStyle(fontSize: 32.0.w, fontWeight: FontWeight.w700),
      colors: widget.text == "COOL DOWN"
          ? const [
              Color(0xff62C1F6),
              Color(0xff6FFFBA),
            ]
          : const [
              Color(0xFFF6D162),
              Color(0xFFFF6F6F),
            ],
    );
  }
}
