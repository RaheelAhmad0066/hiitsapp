import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressWidget extends StatefulWidget {
  final String text;
  final int duration;
  final int count_down;
  final int percent;
  const ProgressWidget(
      {required this.text,
      required this.count_down,
      required this.percent,
      required this.duration});

  @override
  ProgressWidgetClass createState() => ProgressWidgetClass();
}

class ProgressWidgetClass extends State<ProgressWidget> {
  @override
  Widget build(BuildContext context) {
    double percent = 0.0;
    double value_percent = 0.0;
    if (widget.percent > 0) {
      percent = (widget.percent / (widget.duration * 3));
      value_percent = percent > 0.99 ? 0.99 : percent;
    }
    return Container(
        margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: CircularPercentIndicator(
          radius: 110.0.w,
          lineWidth: 10.0.w,
          percent: value_percent,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  color: widget.text == "COOL DOWN"
                      ? Color(0xff62C1F6)
                      : Color(0xFFF6D162),
                ),
              ),
              Text(
                "00:${widget.count_down}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontSize: 64.sp),
              ),
            ],
          ),
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.grey,
          linearGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: widget.text == "COOL DOWN"
                ? const [
                    Color(0xff62C1F6),
                    Color(0xff6FFFBA),
                  ]
                : const [
                    Color(0xFFF6D162),
                    Color(0xFFFF6F6F),
                  ],
          ),
        ));
  }
}
