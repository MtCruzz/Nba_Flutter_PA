import 'package:demo/widgets/statsinfo.widget.dart';
import 'package:flutter/material.dart';

import 'laststatsinfo.widget.dart';

class StatsLineTwoInfos extends StatelessWidget {
  const StatsLineTwoInfos({
    Key key,
    this.firstInfoValue,
    this.secondInfoValue,
    this.firstInfoName,
    this.secondInfoName,
  }) : super(key: key);

  final String firstInfoName;
  final String firstInfoValue;
  final String secondInfoName;
  final String secondInfoValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 40, bottom: 40, left: 70, right: 50),
        child: Row(
          children: [
            StatsInfo(
              title: firstInfoName,
              value: firstInfoValue,
              paddingSize: 80,
            ),
            Spacer(),
            LastStatsInfo(
              title: secondInfoName,
              value: secondInfoValue,
              paddingSize: 25,
            ),
          ],
        ),
      ),
    );
  }
}
