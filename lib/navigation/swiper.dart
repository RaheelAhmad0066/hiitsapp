import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hiits/ui/screens/main_screen/custom_timers.dart';
import 'package:hiits/ui/screens/main_screen/tabata_timer_screen.dart';
import 'package:hiits/ui/storage/storage.dart';

class Swiper extends State<SwiperScreen> {
  final TodoStorage _storage = TodoStorage();
  late PageController _pageController;
  int currentPageIndex;
  List<Widget> _screens = [];
  List<Timer> timers = [];

  Swiper() : currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2232835),
        elevation: 0,
        automaticallyImplyLeading: false, // This line removes the back icon
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(left: 3, right: 3),
                height: 6,
                width: 18,
                decoration: BoxDecoration(
                    color:
                        Color(currentPageIndex == 0 ? 0xFFFFFFFF : 0XFF464C51),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            Container(
                margin: EdgeInsets.only(left: 3, right: 3),
                height: 6,
                width: 18,
                decoration: BoxDecoration(
                    color:
                        Color(currentPageIndex == 1 ? 0xFFFFFFFF : 0XFF464C51),
                    borderRadius: BorderRadius.all(Radius.circular(25.0))))
          ],
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            if (currentPageIndex > 0) {
              changeScreen();
            }
          }
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          onPageChanged: _onPageChange,
          itemBuilder: (BuildContext context, int index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  void changeScreen() {
    _pageController.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadTodos();
    currentPageIndex = 0;
    _pageController = PageController(initialPage: currentPageIndex);
  }

  Future<void> _loadTodos() async {
    var timers = await _storage.getTimers();

    setState(() {
      timers = timers;
    });
    _screens = [
      Container(
        child: TabataTimerScreen(this.nextPage),
      ),
      Container(child: customTimers()
          // timers.length == 0 ? noCustomTimer() : customTimers(),
          ),
    ];
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadTodos();
  }

  void _onPageChange(int index) {
    setState(() {
      currentPageIndex = index;
    });

    if (index == 1) {
      // Index of CustomTimers screen
      print("I'm Active here.");
    }
  }

  void nextPage() {
    _pageController.animateToPage(
      1,
      duration: Duration(milliseconds: 300), // Optional animation duration
      curve: Curves.ease,
    );
  }
}

class SwiperScreen extends StatefulWidget {
  final int currentPageIndex; //  this is to accept the index

  SwiperScreen(this.currentPageIndex); // Constructor accepting the parameter
  @override
  Swiper createState() => Swiper();
}
