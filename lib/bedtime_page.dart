import 'package:flutter/material.dart';
import 'package:flutter_ui_challenge_clock/color.dart';

class BedtimePage extends StatefulWidget {
  @override
  _BedtimePageState createState() => _BedtimePageState();
}

class _BedtimePageState extends State<BedtimePage> {
  final List<String> listDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
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
                'BEDTIME',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bedtime Schedule',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Day Active',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 16),
          Container(
            height: 54,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: listDays.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: (index == 0) ? 0 : 16),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      listDays[index],
                      style: Theme.of(context).textTheme.button,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: (index == 1)
                          ? primaryColor.withOpacity(0.8)
                          : lightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      side: BorderSide(
                        color: Colors.white,
                        width: 4,
                      ),
                      elevation: 0,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Bedtime',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      '11:00 PM',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Wake Up',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      '07:00 PM',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
            child: Image.asset('assets/images/bedtime.png'),
          ),
        ],
      ),
    );
  }
}
