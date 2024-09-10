import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class setCustomTimer extends StatefulWidget {
  final String title;
  final String time;
  final void Function()? decrementCounter;
  final void Function()? incrementCounter;
  const setCustomTimer(
      {required this.title,
      required this.time,
      required this.decrementCounter,
      required this.incrementCounter});

  @override
  setCustomTimerClass createState() => setCustomTimerClass();
}

class setCustomTimerClass extends State<setCustomTimer> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            // decoration: BoxDecoration(
            //   color: Color(0xFF2C313F),
            //   borderRadius: BorderRadius.only(
            //     topRight: Radius.circular(12.w),
            //     topLeft: Radius.circular(12.w),
            //     bottomLeft: Radius.circular(12.w),
            //     bottomRight: Radius.circular(12.w),
            //   ),
            // ),

            decoration: BoxDecoration(
              color: Color(0xFF2C313F),
              border: Border.all(
                color: Color(0xff3D4456),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: MediaQuery.of(context).size.width * .90,
            height: 94.0.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: widget.decrementCounter,
                  child: Row(
                    children: [
                      Align(
                        // alignment: Alignment.centerLeft,
                        child: Image.asset(
                          "assets/icons/minusTime.png",
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                              alignment: Alignment.center,
                              child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.w, top: 8.w),
                                  child: Text(
                                    widget.title,
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xffF7D15E)),
                                  )))),
                      Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xFF2C313F),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12.w),
                                    bottomLeft: Radius.circular(12.w),
                                  )),
                              child: Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    widget.time,
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        // color: Color(0xffffffff))

                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  )))),
                    ]),
                GestureDetector(
                  onTap:
                      // _incrementCounter();
                      widget.incrementCounter,
                  child: Row(
                    children: [
                      Align(
                        child: Image.asset(
                          "assets/icons/addTime.png",
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
