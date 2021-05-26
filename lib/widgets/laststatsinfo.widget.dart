import 'package:flutter/material.dart';

class LastStatsInfo extends StatelessWidget {
  final double paddingSize;

  const LastStatsInfo({Key key, this.paddingSize, this.title, this.value})
      : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(right: paddingSize),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 21,
              ),
            ),
            Text(value),
          ],
        ),
      ),
    );
  }
}
