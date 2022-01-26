import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/models/models_kareem/cupon__sale_icons.dart';
import 'package:vendor/screens/drawer/story/controller/storycontroller.dart';
import 'package:vendor/screens/drawer/story/view/addstory.dart';
import 'package:vendor/screens/drawer/story/view/story.dart';

class MyStories extends StatefulWidget {
  @override
  _MyStoriesState createState() => _MyStoriesState();
}

class _MyStoriesState extends State<MyStories> {
  Future value;
  List stories = [];
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Cupon_Sale.instagram_stories),
        onPressed: () {
          Get.off(() => AddStory());
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AutoSizeText(
          "Stories",
          style: TextStyle(color: Colors.white, fontSize: 20),
          maxLines: 1,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot<dynamic> snap) {
            if (snap.data != null) {
              return ListView.builder(
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Story(
                        id: stories[index]["id"],
                        title: stories[index]["text"],
                        image: stories[index]["Story_Image"]["url"],
                        updateState: updateState,
                      ),
                      Divider(
                        color: Theme.of(context).primaryColor,
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
    stories = await StoryController.getStories();
    return stories;
  }
}
