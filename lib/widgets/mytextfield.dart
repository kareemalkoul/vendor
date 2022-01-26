import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final borderColor;
  final textColor;
  final hintTextColor;
  final hintText;
  final type;
  final Function valControl;
  final Widget counter;
  const MyTextField(
      {this.textColor,
      this.hintText,
      this.hintTextColor,
      this.borderColor,
      this.type,
      this.valControl,
      this.counter});
  dynamic getType() {
    if (type == 1)
      return TextInputType.emailAddress;
    else if (type == 2)
      return TextInputType.number;
    else if (type == 3)
      return TextInputType.text;
    else if (type == 4) return TextInputType.datetime;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: type == 5 ? true : false,
      keyboardType: getType(),
      onChanged: (value) {
        valControl(value);
      },
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
        counter: counter,
        hintStyle: TextStyle(
          color: hintTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
