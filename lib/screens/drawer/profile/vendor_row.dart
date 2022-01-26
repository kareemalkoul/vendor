import 'package:flutter/material.dart';

class VendorRowInfo extends StatelessWidget {
  final String title;
  final IconData icon;
  const VendorRowInfo({Key key, this.title, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 10, 10),
      child: ListTile(
        leading: Icon(icon),
        contentPadding: EdgeInsets.all(0),
        title: Text(
          "$title",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
