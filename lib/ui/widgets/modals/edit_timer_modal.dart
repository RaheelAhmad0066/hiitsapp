import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class editModal extends StatefulWidget {
  const editModal({
    super.key,
  });

  @override
  State<editModal> createState() => _editModal();
}

class _editModal extends State<editModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: SizedBox(
        height: 220.h,

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff242935),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Wrap(
                      // alignment: Alignment.center,
                      children: [
                        Container(
                            width: 250.w,
                            child: Text(
                              "Do you want to leave? You will lose the changes you made.",
                              maxLines: 2,
                              // widget.name,
                              softWrap: true,

                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xffffffff),
                                // fontWeight: FontWeight.w700,
                                fontSize: 18.0.sp,
                              ),
                            ))
                      ],
                    ),
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
                  ],
                ),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: (Color(0xff363D4D))),
                        onPressed: () {
                          int count = 0;
                          Navigator.of(context).popUntil((_) => count++ >= 2);
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                          ),
                          // )),
                        ))),
                Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: (Color(0xff363D4D))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                          ),
                          // )),
                        ))),
              ],
            ),
          ),
        ),
        // ),
      ),
    );
  }
}
