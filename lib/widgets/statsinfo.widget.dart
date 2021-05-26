import 'package:flutter/material.dart';

class StatsInfo extends StatelessWidget {
  const StatsInfo({
    Key key,
    this.paddingSize,
    this.title,
    this.value,
  }) : super(key: key);

  final double paddingSize;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
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
