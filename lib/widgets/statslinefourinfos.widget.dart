import 'package:demo/widgets/laststatsinfo.widget.dart';
import 'package:demo/widgets/statsinfo.widget.dart';
import 'package:flutter/material.dart';

class StatsLineFourInfos extends StatelessWidget {
  const StatsLineFourInfos({
    Key key,
    this.firstInfoValue,
    this.secondInfoValue,
    this.thirdInfoValue,
    this.fourthInfoValue,
    this.firstInfoName,
    this.secondInfoName,
    this.thirdInfoName,
    this.fourthInfoName,
  }) : super(key: key);

  final String firstInfoName;
  final String firstInfoValue;
  final String secondInfoName;
  final String secondInfoValue;
  final String thirdInfoName;
  final String thirdInfoValue;
  final String fourthInfoName;
  final String fourthInfoValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 40, bottom: 40, left: 20),
        child: Row(
          children: [
            StatsInfo(
              title: firstInfoName,
              value: firstInfoValue,
              paddingSize: 27,
            ),
            Spacer(),
            StatsInfo(
              title: secondInfoName,
              value: secondInfoValue,
              paddingSize: 27,
            ),
            Spacer(),
            StatsInfo(
              title: thirdInfoName,
              value: thirdInfoValue,
              paddingSize: 27,
            ),
            Spacer(),
            LastStatsInfo(
              title: fourthInfoName,
              value: fourthInfoValue,
              paddingSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
