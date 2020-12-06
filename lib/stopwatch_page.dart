import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'color.dart';

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  int indexButton;

  final List<StopwatchData> list = [
    StopwatchData(title: 'Lap 5', time: '00:07.23'),
    StopwatchData(title: 'Lap 4', time: '00:06.10'),
    StopwatchData(title: 'Lap 3', time: '00:02.24'),
    StopwatchData(title: 'Lap 2', time: '00:05.50'),
    StopwatchData(title: 'Lap 1', time: '00:02.30'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
              'STOPWATCH',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                color: shadowColor.withOpacity(0.14),
                blurRadius: 64,
              ),
            ],
          ),
          child: Image.asset('assets/images/stopwatch.png'),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: buttonWidget(
                widget: Text(
                  'Reset',
                  style: Theme.of(context).textTheme.button,
                ),
                isActive: false,
              ),
            ),
            SizedBox(width: 40),
            Expanded(
              child: buttonWidget(
                widget: Text(
                  'Start',
                  style: Theme.of(context).textTheme.button,
                ),
                isActive: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        ...List.generate(
          list.length,
          (index) => Container(
            margin: EdgeInsets.only(top: (index == 0) ? 0 : 16),
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: [
                IconSlideAction(
                  color: Colors.transparent,
                  iconWidget: Icon(
                    Icons.delete,
                    color: fabColor,
                  ),
                ),
              ],
              child: buttonWidget(
                widget: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        list[index].title,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        list[index].time,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                isActive: false,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buttonWidget({Widget widget, bool isActive}) {
    return ElevatedButton(
      onPressed: () {},
      child: widget,
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

class StopwatchData {
  final String title;
  final String time;

  StopwatchData({this.title, this.time});
}
