import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutCompleteWidget extends StatefulWidget {
  final double MaincontainerWidth;
  final double MaincontainerHeight;
  final double WorkRestContainerHeight;
  final double WorkRestContainerWidth;
  final double titleFontSize;
  final String title;
  final String number;
  final dynamic boxColor;
  final bool isGradient;
  const WorkoutCompleteWidget({
    required this.MaincontainerWidth,
    required this.MaincontainerHeight,
    required this.WorkRestContainerHeight,
    required this.WorkRestContainerWidth,
    required this.titleFontSize,
    required this.title,
    required this.number,
    required this.isGradient,
    required this.boxColor,
  });

  @override
  WorkoutCompleteWidgetClass createState() => WorkoutCompleteWidgetClass();
}

class WorkoutCompleteWidgetClass extends State<WorkoutCompleteWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(children: [
          Container(
              width: widget.MaincontainerWidth,
              height: widget.MaincontainerHeight,
              decoration: BoxDecoration(
                  color: widget.boxColor,
                  gradient: widget.isGradient
                      ? LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF43475A),
                            Color(0xFF43475A),
                            Color(0xFF),
                          ],
                        )
                      : null,
                  borderRadius: BorderRadius.all(Radius.circular(12.0.w))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Container(
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                  color: widget.boxColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12.w),
                                    topLeft: Radius.circular(12.w),
                                  ),
                                ),
                                height: widget.WorkRestContainerHeight + 12,
                                width: widget.WorkRestContainerWidth,
                                child: Text(
                                  widget.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 38.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ))),
                        Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Container(
                                // alignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                    color: widget.boxColor,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(12.w),
                                      bottomLeft: Radius.circular(12.w),
                                    )),
                                height: widget.WorkRestContainerHeight - 12,
                                width: widget.WorkRestContainerWidth,
                                child: Text(
                                  widget.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xFF878894),
                                      fontSize: widget.titleFontSize,
                                      fontWeight: FontWeight.w700),
                                ))),
                      ]),
                ],
              )),
        ]));
  }
}
