import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class bottomModal extends StatefulWidget {
  final String? Text;
  final String buttonOneText;
  final String buttonTwoText;
  final VoidCallback onPressedButtonOne;
  final VoidCallback onPressedButtonTwo;
  final Color buttonOneColor;
  final Color buttonTwoColor;
  final Color buttonTextColor;

  const bottomModal({
    super.key,
    this.Text,
    required this.buttonOneText,
    required this.buttonTwoText,
    required this.onPressedButtonOne,
    required this.onPressedButtonTwo,
    required this.buttonOneColor,
    required this.buttonTwoColor,
    required this.buttonTextColor,
  });

  @override
  State<bottomModal> createState() => _bottomModal();
}

class _bottomModal extends State<bottomModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      margin: EdgeInsets.all(20),
      child: SizedBox(
        height: 250.h,

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff242935),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      child: Image.asset(
                        "assets/icons/crose.png",
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.Text!,
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontFamily: 'InterBold',
                      // fontWeight: FontWeight.w700,
                      fontSize: 20.0.sp,
                    ),
                  ),
                ),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: widget.buttonOneColor),
                        onPressed: widget.onPressedButtonOne,
                        child: Text(
                          widget.buttonOneText,
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontFamily: 'InterBold',
                              fontSize: 15),
                          // )),
                        ))),
                Container(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: widget.buttonTwoColor),
                        onPressed: widget.onPressedButtonTwo,
                        child: Text(
                          widget.buttonTwoText,
                          style: TextStyle(
                              color: widget.buttonTextColor,
                              fontFamily: 'InterBold',
                              fontSize: 15),
                          // )),
                        ))),
              ],
            ),
          ),
        ),
        // ),
      ),
    ));
  }
}
