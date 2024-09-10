import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hiits/appassets/apptextstyle.dart';

class TimeSectionWidget extends StatefulWidget {
  final double MaincontainerWidth;
  final double MaincontainerHeight;
  final double WorkRestContainerHeight;
  final double WorkRestContainerWidth;
  final String title;
  final String time;
  const TimeSectionWidget(
      {required this.MaincontainerWidth,
      required this.MaincontainerHeight,
      required this.WorkRestContainerHeight,
      required this.WorkRestContainerWidth,
      required this.title,
      required this.time});

  @override
  TimeSectionWidgetClass createState() => TimeSectionWidgetClass();
}

class TimeSectionWidgetClass extends State<TimeSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
            width: widget.MaincontainerWidth,
            height: widget.MaincontainerHeight,
            decoration: BoxDecoration(
                color: Color(0xFF2C313F),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF43475A),
                    Color(0xFF43475A),
                    Color(0xFF),
                  ],
                ),
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

                              // alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xFF2C313F),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12.w),
                                  topLeft: Radius.circular(12.w),
                                ),
                              ),
                              height: widget.WorkRestContainerHeight,
                              width: widget.WorkRestContainerWidth,
                              child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.w, top: 10.w),
                                  child: Text(
                                    widget.title,
                                    style: AppTextStyles.medium
                                        .copyWith(fontSize: 17),
                                  )))),
                      Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFF2C313F),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12.w),
                                    bottomLeft: Radius.circular(12.w),
                                  )),
                              height: widget.WorkRestContainerHeight,
                              width: widget.WorkRestContainerWidth,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 15.w),
                                  child: Text(widget.time,
                                      style: AppTextStyles.medium.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold))))),
                    ]),
              ],
            )));
  }
}
