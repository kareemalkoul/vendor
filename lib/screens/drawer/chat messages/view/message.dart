import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';

class Message extends StatefulWidget {
  final message;
  Message({this.message});
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: AutoSizeText(
            "Messages",
            style: TextStyle(color: Colors.white, fontSize: 20),
            maxLines: 1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        drawer: Container(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getHeight(50),
              ),
              Row(
                children: [
                  SizedBox(
                    width: getWidth(30),
                  ),
                  AutoSizeText(
                    "Message",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(50),
              ),
              AutoSizeText(
                widget.message,
              ),
            ],
          ),
        ));
  }
}
