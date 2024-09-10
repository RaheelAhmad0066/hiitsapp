import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class appBar extends StatefulWidget {
  final Widget title;
  final String? Text;
  final Widget body;
  const appBar({Key? key, required this.title, required this.body, this.Text})
      : super(key: key);

  @override
  State<appBar> createState() => _appBar();
}

class _appBar extends State<appBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF252835),
        elevation: 0,
        centerTitle: true,
        titleSpacing: -40,
        title: widget.title,
        leading: Image.asset(
          "assets/icons/goBack.png",
        ),
        actions: [
          Center(
              child: Padding(
            padding: EdgeInsets.only(right: 20),
            child: Text(
              widget.Text ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xffF7D15E),
                  fontSize: 17.0,
                  fontFamily: 'Inter'),
            ),
          )),
        ],
      ),
      body: widget.body,
    ));
  }
}
