import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/drawer/chat%20messages/controller/chatmessagescontroller.dart';
import 'package:vendor/widgets/mybutton.dart';
import 'package:vendor/widgets/mytextfield.dart';

class Reply extends StatefulWidget {
  final to;
  Reply({this.to});

  @override
  _ReplyState createState() => _ReplyState();
}

class _ReplyState extends State<Reply> {
  var message;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Home"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        backgroundColor: Colors.white,
        body: loading
            ? Center(
                child: SizedBox(
                  height: getHeight(200),
                  width: getWidth(200),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: getHeight(100),
                    ),
                    AutoSizeText(
                      "To : ${widget.to}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: getHeight(100),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: getWidth(50),
                            ),
                            AutoSizeText(
                              "Message :",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: MyTextField(
                            type: 3,
                            borderColor: Theme.of(context).primaryColor,
                            hintText: "",
                            hintTextColor: Colors.grey.shade400,
                            textColor: Theme.of(context).primaryColor,
                            valControl: (value) {
                              message = value;
                              print(message);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(150),
                    ),
                    MyButton(
                      buttonColor: Theme.of(context).primaryColor,
                      text: "Send",
                      textColor: Colors.white,
                      height: getHeight(50),
                      width: getWidth(200),
                      fun: () async {
                        var checkRes = ChatMessagesController.check(message);
                        print(checkRes);
                        if (checkRes != 1) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("$checkRes"),
                            backgroundColor: Colors.lightBlue,
                          ));
                          return;
                        }

                        setState(() {
                          loading = !loading;
                        });
                        var res = await ChatMessagesController.sendMessage(
                            widget.to, message);
                        if (res != false) {
                          Get.back();
                        }
                      },
                    ),
                  ],
                ),
              ));
  }
}
