import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/drawer/doc/controller/documentcontroller.dart';
import 'package:vendor/screens/drawer/doc/view/document.dart';
import 'package:vendor/screens/drawer/story/controller/storycontroller.dart';

import 'package:vendor/widgets/mybutton.dart';
import 'package:vendor/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class AddDoc extends StatefulWidget {
  @override
  _AddDocState createState() => _AddDocState();
}

class _AddDocState extends State<AddDoc> {
  var text;
  bool loading = false;
  var image;
  bool isback = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        isback == true ? Get.back() : null;
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add document",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getHeight(90),
                      ),
                      SizedBox(
                        width: getWidth(340),
                        child: MyTextField(
                          type: 3,
                          borderColor: Theme.of(context).primaryColor,
                          hintText: "text",
                          hintTextColor: Colors.grey.shade400,
                          textColor: Theme.of(context).primaryColor,
                          valControl: (value) {
                            text = value;
                            print(text);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getHeight(50),
                      ),
                      Container(
                        height: getHeight(200),
                        child: Row(
                          children: [
                            SizedBox(
                              width: getWidth(40),
                            ),
                            InkWell(
                              onTap: () async {
                                var pickedImage = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                setState(() {
                                  image = pickedImage;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                    )),
                                width: getWidth(100.0),
                                height: getHeight(170.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      height: getHeight(30),
                                    ),
                                    Text(
                                      "Add image",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getWidth(20),
                            ),
                            Container(
                              height: getHeight(170),
                              width: getWidth(210),
                              child: image == null
                                  ? AutoSizeText("")
                                  : InkWell(
                                      onLongPress: () {
                                        setState(() {
                                          image = null;
                                        });
                                      },
                                      child: ListImage(
                                        image: image,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeight(50),
                      ),
                      MyButton(
                        buttonColor: Theme.of(context).primaryColor,
                        text: "Add",
                        textColor: Colors.white,
                        height: getHeight(50),
                        width: getWidth(200),
                        fun: () async {
                          if (image == null ||
                              image.path == "" ||
                              text == null ||
                              text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text("please complete information"),
                              backgroundColor: Colors.lightBlue,
                            ));
                            return;
                          }
                          isback = false;
                          setState(() {
                            loading = !loading;
                          });

                          var docID =
                              await DocumentController.addDoc(image, text);

                          Get.off(() => Documents());
                          isback = true;
                        },
                      ),
                      SizedBox(
                        height: getHeight(50),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class ListImage extends StatelessWidget {
  final image;
  ListImage({this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: getHeight(170),
          width: getWidth(100),
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: FileImage(File(image.path))),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        SizedBox(
          width: getWidth(10),
        ),
      ],
    );
  }
}
