import 'package:flutter/material.dart';

class HeaderInfo extends StatelessWidget {
  const HeaderInfo({
    Key key,
    @required this.firstName,
    @required this.lastName,
    this.teamName,
  }) : super(key: key);

  final String firstName;
  final String lastName;
  final String teamName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Image.network(
            'https://nba-players.herokuapp.com/players/$lastName/$firstName',
            width: 200,
            height: 200,
          ),
        ),
        Column(
          children: [
            Text(teamName),
            Text(
              ' $firstName\n $lastName',
              style: TextStyle(fontSize: 30),
            ),
          ],
        )
      ],
    );
  }
}
