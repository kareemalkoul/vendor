import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final borderColor;
  final containerColor;
  final child;
  final width;
  final height;
  final text;
  ProfileInfo(
      {this.containerColor,
      this.borderColor,
      this.width,
      this.height,
      this.child,
      this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(width: 15),
          Text(
            text,
            style: TextStyle(color: Colors.lightBlue),
          ),
          SizedBox(width: 20),
          child,
        ],
      ),
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
          )),
    );
  }
}
