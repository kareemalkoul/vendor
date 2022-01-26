import 'dart:convert';
import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/imageuploader.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/requests.dart';

class DocumentController {
  static Future getDocument() async {
    var id;
    var profileBody;
    User user = await PrefHandler.getUser();
    print(user.id);
    id = user.id;
    profileBody = await Requests.getRequest(
        "https://floating-badlands-10743.herokuapp.com/api/documents/find_vendor/$id");

    if (profileBody == false) return [];
    return jsonDecode(profileBody);
  }

  static Future addDoc(dynamic image, dynamic name) async {
    var id;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    print(name);
    var res = await ImageUploader.uploadImage(
        "https://floating-badlands-10743.herokuapp.com/api/documents/new",
        {"name": name, "vendor_id": id},
        image);
  }

  static Future deleteDoc(dynamic id) async {
    var res = await Requests.deleteRequest(
        "https://floating-badlands-10743.herokuapp.com/api/documents/delete/$id");
    return res;
  }
}
