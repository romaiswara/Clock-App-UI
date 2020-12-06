import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ui_challenge_clock/color.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  TimeOfDay _timeOfDay = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeOfDay.minute != TimeOfDay.now().minute) {
        setState(() {
          _timeOfDay = TimeOfDay.now();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _period = _timeOfDay.period == DayPeriod.am ? "AM" : "PM";
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                'WORLD CLOCK',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          SizedBox(height: 28),
          Text(
            "${_timeOfDay.hourOfPeriod.toString().padLeft(2, '0')}:${_timeOfDay.minute.toString().padLeft(2, '0')} $_period",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 28),
          ClockWidget(),
          SizedBox(height: 36),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                dotWidget(Colors.black54),
                SizedBox(width: 6),
                dotWidget(Colors.white),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: buttonWidget(
                  text: 'LONDON',
                  isActive: true,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: buttonWidget(
                  text: 'NEW YORK',
                  isActive: false,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget dotWidget(Color color) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget buttonWidget({String text, bool isActive}) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        text,
        style: Theme.of(context).textTheme.button,
      ),
      style: ElevatedButton.styleFrom(
          primary: isActive ? primaryColor.withOpacity(0.8) : lightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          side: BorderSide(
            color: Colors.white,
            width: 4,
          ),
          padding: EdgeInsets.symmetric(vertical: 20)),
    );
  }
}

class ClockWidget extends StatefulWidget {
  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  DateTime _dateTime = DateTime.now();
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: AspectRatio(
        aspectRatio: 1,
        child: Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            painter: ClockPainter(dateTime: _dateTime),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime dateTime;

  ClockPainter({this.dateTime});

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = Colors.white;

    canvas.drawCircle(center, radius, fillBrush);

    var outlineBrush = Paint()
      ..color = lightColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 42;

    canvas.drawCircle(center, radius, outlineBrush);

    var dashBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 6;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }

    // draw shadow
    Path oval = Path()
      ..addOval(
        Rect.fromCircle(center: center, radius: radius / 4),
      );

    Paint shadowPaint = Paint()
      ..color = shadowColor.withOpacity(0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, 8);

    canvas.drawPath(oval, shadowPaint);

    var hourHandBrush = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandBrush = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandBrush = Paint()
      ..color = fabColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    var secHandX = centerX + 115 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 115 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    var centerFillBrush = Paint()..color = fabColor;

    canvas.drawCircle(center, 8, centerFillBrush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
