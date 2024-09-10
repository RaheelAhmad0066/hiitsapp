import 'package:flutter/material.dart';
import 'package:hiits/navigation/swiper.dart';
import 'package:hiits/ui/screens/workout/custom_workouts/custom_workouts.dart';
import 'package:hiits/ui/widgets/sidebar/sidebar.dart';

const defaultLetterSpacing = 0.03;

const Color shrineBackgroundWhite = Colors.white;
const Color shrineBrown600 = Color(0xFF7D4F52);
const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineErrorRed = Color(0xFFC5032B);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);
const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink100,
  secondary: shrinePink50,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

class BottomTab extends StatefulWidget {
  final int initialIndex;
  final bool? showWorkouts;
  final Function? nextPage;
  final int currentPageIndex;

  BottomTab({
    this.initialIndex = 0,
    this.showWorkouts,
    this.currentPageIndex = 0,
    this.nextPage,
  });

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _currentIndex = 0;

  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // Use the passed initial index

    screens = [
      SwiperScreen(
          widget.currentPageIndex), // Pass the current index to SwiperScreen
      customWorkouts(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: Sidebar(),
      body: Stack(
        children: [
          screens[_currentIndex],
          Positioned(
            top: 40.0,
            left: 16,
            child: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Image.asset(
                  'assets/icons/sidebar_icon.png',
                  height: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.12,
        child: BottomNavigationBar(
          elevation: 0.0,
          currentIndex: _currentIndex,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(left: 50),
                width: screenWidth * (_currentIndex == 0 ? 0.5 : 0.5),
                height: screenHeight * 0.07,
                child: Image.asset(_currentIndex == 0
                    ? "assets/icons/timer_tab_active.png"
                    : "assets/icons/timer_tab_inactive.png"),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(right: 50),
                width: screenWidth * (_currentIndex == 1 ? 0.5 : 0.5),
                height: screenHeight * 0.07,
                child: Image.asset(_currentIndex == 1
                    ? "assets/icons/workout_tab_active.png"
                    : "assets/icons/workout_tab_inactive.png"),
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
