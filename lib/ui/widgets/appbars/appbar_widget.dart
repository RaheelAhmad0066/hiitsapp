import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends State {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Color(0xFF252835),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                margin: EdgeInsets.only(left: 5.w, right: 5.w),
                height: 6.h,
                width: 18.w,
                decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.all(Radius.circular(25.0.w)))),
            Container(
                height: 6.h,
                width: 18.w,
                decoration: BoxDecoration(
                    color: Color(0XFF464C51),
                    borderRadius: BorderRadius.all(Radius.circular(25.0.w))))
          ],
        ));
  }
}
