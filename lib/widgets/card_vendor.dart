import 'package:flutter/material.dart';

class CardVendor extends StatelessWidget {
  final child;
  const CardVendor({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        child: child,
        data: Theme.of(context).copyWith(
          textTheme: TextTheme().apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
            decorationColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
