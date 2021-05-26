import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextForm extends StatelessWidget {
  TextForm({Key key, this.hintText, this.controller}) : super(key: key);

  var controller = new TextEditingController();
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          hintText: hintText,
          filled: true,
          fillColor: Colors.white),
      autofocus: true,
    );
  }
}
