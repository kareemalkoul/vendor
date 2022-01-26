import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/drawer/story/controller/storycontroller.dart';

class Story extends StatelessWidget {
  final title;
  final image;
  final id;
  Function updateState;
  Story({this.id, this.title, this.image, this.updateState});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(200),
      child: Column(
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
                height: getHeight(100),
                width: getWidth(100),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(image)),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
              SizedBox(
                width: getWidth(50),
              ),
              Text(
                "$title",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
          SizedBox(
            height: getHeight(20),
          ),
          Row(
            children: [
              SizedBox(
                width: getWidth(330),
              ),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    var res = await StoryController.deleteStory(id);
                    if (res == false) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("error"),
                        backgroundColor: Theme.of(context).primaryColor,
                      ));
                    }
                    updateState();
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
