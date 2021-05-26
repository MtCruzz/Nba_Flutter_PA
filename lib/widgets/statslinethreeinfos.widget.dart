import 'package:demo/widgets/laststatsinfo.widget.dart';
import 'package:demo/widgets/statsinfo.widget.dart';
import 'package:flutter/material.dart';

class StatsLineThreeInfos extends StatelessWidget {
  const StatsLineThreeInfos({
    Key key,
    this.firstInfoValue,
    this.secondInfoValue,
    this.thirdInfoValue,
    this.firstInfoName,
    this.secondInfoName,
    this.thirdInfoName,
  }) : super(key: key);

  final String firstInfoName;
  final String firstInfoValue;
  final String secondInfoName;
  final String secondInfoValue;
  final String thirdInfoName;
  final String thirdInfoValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 40, bottom: 40, left: 30, right: 15),
        child: Row(
          children: [
            StatsInfo(
              title: firstInfoName,
              value: firstInfoValue,
              paddingSize: 50,
            ),
            Spacer(),
            StatsInfo(
              title: secondInfoName,
              value: secondInfoValue,
              paddingSize: 50,
            ),
            Spacer(),
            LastStatsInfo(
              title: thirdInfoName,
              value: thirdInfoValue,
              paddingSize: 25,
            ),
          ],
        ),
      ),
    );
  }
}
