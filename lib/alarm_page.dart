import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_challenge_clock/color.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  final List<AlarmData> list = [
    AlarmData(title: 'Everyday', time: '05:00', isActive: true),
    AlarmData(title: 'SAT, MON', time: '08:00', isActive: false),
    AlarmData(title: 'Everyday', time: '10:00', isActive: false),
    AlarmData(title: 'SUN, MON, TUE', time: '08:00', isActive: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        physics: BouncingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
                child: Icon(Icons.menu_rounded),
              ),
              Text(
                'ALARM',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
              list.length,
              (index) => Container(
                margin: EdgeInsets.only(top: (index == 0) ? 0 : 20),
                child: AlarmWidget(
                  data: list[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlarmWidget extends StatefulWidget {
  final AlarmData data;

  AlarmWidget({this.data});

  @override
  _AlarmWidgetState createState() => _AlarmWidgetState();
}

class _AlarmWidgetState extends State<AlarmWidget>
    with SingleTickerProviderStateMixin {
  Animation _circleAnimation;
  AnimationController _animationController;
  bool isActive;

  @override
  void initState() {
    super.initState();
    // set active
    isActive = widget.data.isActive;

    // init animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 60),
    );

    // init animation
    _circleAnimation = AlignmentTween(
      begin: isActive ? Alignment.topCenter : Alignment.bottomCenter,
      end: isActive ? Alignment.bottomCenter : Alignment.topCenter,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> days = widget.data.title.split(',');
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 24,
            ),
            decoration: BoxDecoration(
              color: isActive ? primaryColor.withOpacity(0.75) : lightColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 4,
                  direction: Axis.horizontal,
                  children: List.generate(
                    days.length,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        days[index],
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'AM',
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                color: isActive
                                    ? Colors.white.withOpacity(0.5)
                                    : darkColor,
                              ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          widget.data.time,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          flex: 1,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        print('animation value: ${_circleAnimation.value}');
                        if (_animationController.isCompleted) {
                          _animationController.reverse();
                          setState(() {
                            isActive = !isActive;
                          });
                        } else {
                          _animationController.forward();
                          setState(() {
                            isActive = !isActive;
                          });
                        }
                      },
                      child: Container(
                        width: 76,
                        height: 125,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: lightColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Align(
                              alignment: _circleAnimation.value,
                              child: Container(
                                width: 60,
                                height: 60,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (_circleAnimation.value ==
                                          Alignment.topCenter)
                                      ? primaryColor
                                      : accentColor,
                                ),
                                child: Center(
                                  child: (_circleAnimation.value ==
                                          Alignment.topCenter)
                                      ? Text(
                                          'ON',
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                        )
                                      : Text(
                                          'OFF',
                                          style: Theme.of(context)
                                              .textTheme
                                              .button
                                              .copyWith(
                                                color: darkColor,
                                              ),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AlarmData {
  final String title;
  final String time;
  final bool isActive;

  AlarmData({this.title, this.time, this.isActive});
}
