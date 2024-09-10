import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalLayout extends StatefulWidget {
  final String name;
  final String rightItem;
  final String image;
  final VoidCallback onPressed;

  HorizontalLayout(
      {required this.name,
      required this.rightItem,
      required this.image,
      required this.onPressed});
  @override
  _HorizontalLayout createState() => _HorizontalLayout();
}

class _HorizontalLayout extends State<HorizontalLayout>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 14.w, top: 20),
              child: Text(
                widget.name,
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Hind'),
              )),
          GestureDetector(
              onTap: widget.onPressed,
              child: Container(
                padding: EdgeInsets.only(right: 14.w, top: 20),
                child: Row(children: [
                  Container(
                      padding: EdgeInsets.only(right: 7.w),
                      child: Text(
                        widget.rightItem,
                        style: TextStyle(
                          color: Color(0xffF7D15E),
                          fontWeight: FontWeight.w700,
                          fontSize: 19.sp,
                        ),
                      )),
                  Image.asset(
                    widget.image,
                    width: 18,
                    height: 18,
                  ),
                ]),
              )),
        ]);
  }
}
