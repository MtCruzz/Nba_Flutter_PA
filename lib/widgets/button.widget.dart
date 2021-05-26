import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key key,
    this.title,
    this.onPress,
  }) : super(key: key);

  final String title;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
