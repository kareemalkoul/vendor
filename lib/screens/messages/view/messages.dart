import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/messages/controller/messagescontroller.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  Future value;
  List messages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = getData();
  }

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
      body: FutureBuilder(
        builder: (context, AsyncSnapshot<dynamic> snap) {
          if (snap.data != null) {
            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: getHeight(20),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: getWidth(30),
                        ),
                        Container(
                          height: getHeight(50),
                          width: getWidth(150),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Center(
                            child: AutoSizeText(
                              messages[index]["text"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(20),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1.5,
                    ),
                  ],
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );
        },
        future: value,
      ),
    );
  }

  Future getData() async {
    messages = await MessagesController.getMessages();
    return messages;
  }
}
