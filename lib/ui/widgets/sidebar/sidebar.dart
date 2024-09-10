import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiits/appassets/apptextstyle.dart';
import 'package:hiits/navigation/bottom_tab.dart';
import 'package:hiits/ui/screens/main_screen/setting_screen.dart';

const defaultLetterSpacing = 0.03;

class Sidebar extends StatefulWidget {
  final int initialIndex;
  final bool? showWorkouts;
  final Function? nextPage;
  final int currentPageIndex; // Add this to accept the page index

  Sidebar({
    this.initialIndex = 0,
    this.showWorkouts,
    this.currentPageIndex = 0,
    this.nextPage,
  });

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            color: Color(0xFF252835),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/icons/hiits_workout_logo.png',
                        // width: 100,
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFF252835),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomTab(
                                    initialIndex: 1,
                                  )));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          bottom: 20.0, left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          color: Color(0xFF2C313F),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/icons/workout.png',
                        ),
                        title: Text('Workout', style: AppTextStyles.medium),
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(
                  //       bottom: 20.0, left: 10.0, right: 10.0),
                  //   decoration: BoxDecoration(
                  //     color: Color(0xFF2C313F),
                  //     borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  //   child: ListTile(
                  //     leading: Image.asset(
                  //       'assets/icons/timer.png',
                  //     ),
                  //     title: Text('My Timers',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w400,
                  //         )),
                  //     onTap: () {
                  //       // Do nothing on tap
                  //     },
                  //   ),
                  // ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BottomTab(currentPageIndex: 1),
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          bottom: 20.0, left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          color: Color(0xFF2C313F),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/icons/timer.png',
                        ),
                        title: Text('My Timers', style: AppTextStyles.medium),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(
                        bottom: 20.0, left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF2C313F),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/icons/settings.png',
                      ),
                      title: Text('Settings', style: AppTextStyles.medium),
                      onTap: () {
                        Get.to(SettingScreen());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
