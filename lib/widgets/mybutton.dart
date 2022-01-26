import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final height;
  final width;
  final text;
  final buttonColor;
  final textColor;
  Function fun;

  MyButton({this.textColor,this.height,this.width,this.buttonColor,this.text,this.fun});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      onTap: fun,
    );
  }
}
