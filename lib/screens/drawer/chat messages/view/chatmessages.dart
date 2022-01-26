import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/drawer/chat messages/controller/chatmessagescontroller.dart';
import 'package:vendor/screens/drawer/chat messages/view/reply.dart';
import 'package:vendor/screens/messages/controller/messagescontroller.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';
import 'message.dart';

class ChatMessages extends StatefulWidget {
  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  Future value;
  List messages = [];
  Function updateState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = getData();
    updateState = () {
      print("called");
      setState(() {
        value = null;
        value = getData();
      });
    };
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
      body: SafeArea(
        child: FutureBuilder(
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
                                messages[index]["from"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: getWidth(150),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () async {
                                var res =
                                    await ChatMessagesController.deleteMessage(
                                        messages[index]["id"]);
                                if (res == false) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("error occurred"),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  ));
                                } else {
                                  updateState();
                                }
                              })
                        ],
                      ),
                      SizedBox(
                        height: getHeight(20),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: getWidth(30),
                          ),
                          AutoSizeText(
                            messages[index]["text"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getHeight(20),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: getWidth(30),
                          ),
                          InkWell(
                            child: AutoSizeText(
                              "Read",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                              maxLines: 1,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Message(
                                            message: messages[index]["text"],
                                          )));
                            },
                          ),
                          SizedBox(
                            width: getWidth(250),
                          ),
                          InkWell(
                            child: AutoSizeText(
                              "Reply",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                              maxLines: 1,
                            ),
                            onTap: () {
                              Get.to(() => Reply(
                                    to: messages[index]["from"],
                                  ));
                            },
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
      ),
    );
  }

  Future getData() async {
    messages = await ChatMessagesController.getMessages();
    return messages;
  }
}
