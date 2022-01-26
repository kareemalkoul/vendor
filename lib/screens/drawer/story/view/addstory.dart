import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/drawer/story/controller/storycontroller.dart';
import 'package:vendor/screens/drawer/story/view/mystories.dart';

import 'package:vendor/widgets/mybutton.dart';
import 'package:vendor/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class AddStory extends StatefulWidget {
  @override
  _AddStoryState createState() => _AddStoryState();
}

class _AddStoryState extends State<AddStory> {
  var text;
  var minutes;
  var hour;
  var day;
  var month;
  var year;
  bool loading = false;
  var image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Story",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: loading
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
                          if (text == null ||
                              text == "" ||
                              image == null ||
                              image.path == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text("please complete information "),
                              backgroundColor: Colors.lightBlue,
                            ));
                            return;
                          }
                          setState(() {
                            loading = !loading;
                          });
                          DateTime now = new DateTime.now();
                          DateTime date = new DateTime(now.year, now.month,
                              now.day, now.hour, now.minute);
                          day = date.day;
                          month = date.month;
                          year = date.year;
                          hour = date.hour;
                          minutes = date.minute;
                          var storyId = await StoryController.addStory(
                              text, day, month, year, hour, minutes);
                          if (storyId != null) {
                            await StoryController.addStoryImage(image, storyId);
                          }

                          Get.off(() => MyStories());
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
