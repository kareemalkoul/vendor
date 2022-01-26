import 'dart:convert';

import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/imageuploader.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';

import 'package:vendor/requests_handling/requests.dart';

class StoryController {
  static Future getStories() async {
    var id;
    var profileBody;
    User user = await PrefHandler.getUser();
    print(user.id);
    id = user.id;
    profileBody = await Requests.getRequest(
        "https://floating-badlands-10743.herokuapp.com/api/story/find_vendor/$id");

    if (profileBody == false) return [];
    return jsonDecode(profileBody);
  }

  static Future addStory(dynamic text, dynamic day, dynamic month, dynamic year,
      dynamic hour, dynamic minutes) async {
    var id;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    print(id);

    var res = await Requests.postRequest(
        "https://floating-badlands-10743.herokuapp.com/api/story/new", {
      "text": text,
      "vendor_id": id,
      "date_of_end": "$year-$month-${day + 1}",
      "minut": minutes,
      "hour": hour,
    });
    var body = jsonDecode(res.body);
    var storyId = body["id"];
    if (res.statusCode == 200) return storyId;
  }

  static Future addStoryImage(dynamic image, dynamic id) async {
    var res = await ImageUploader.uploadImage(
        "https://floating-badlands-10743.herokuapp.com/api/story_image/new",
        {"story_id": id},
        image);
  }

  static Future deleteStory(dynamic id) async {
    var res = await Requests.deleteRequest(
        "https://floating-badlands-10743.herokuapp.com/api/story/delete/$id");
    return res;
  }
}
