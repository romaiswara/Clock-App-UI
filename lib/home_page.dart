import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_challenge_clock/alarm_page.dart';
import 'package:flutter_ui_challenge_clock/bedtime_page.dart';
import 'package:flutter_ui_challenge_clock/clock_page.dart';
import 'package:flutter_ui_challenge_clock/color.dart';
import 'package:flutter_ui_challenge_clock/stopwatch_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _bottomNavIndex = 0;

  final iconList = <IconData>[
    Icons.schedule,
    Icons.alarm,
    Icons.king_bed_outlined,
    Icons.timer,
  ];

  List<Widget> get pages => [
        ClockPage(),
        AlarmPage(),
        BedtimePage(),
        StopwatchPage(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _bottomNavIndex,
          children: <Widget>[...pages],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        child: Icon(Icons.add),
        backgroundColor: fabColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        backgroundColor: accentColor,
        activeColor: primaryColor,
        inactiveColor: Colors.white,
      ),
    );
  }
}
