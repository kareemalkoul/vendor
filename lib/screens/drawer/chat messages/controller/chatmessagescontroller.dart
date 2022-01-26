import 'dart:convert';
import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/requests.dart';

class ChatMessagesController {
  static Future getMessages() async {
    // User user = await PrefHandler.getUser();
    var email;
    User user = await PrefHandler.getUser();
    print(user.email);
    email = user.email;
    print("!");

    var profileBody = await Requests.getRequest(
        "https://floating-badlands-10743.herokuapp.com/api/messages/find_to/${email}");

    if (profileBody == false) return [];
    return jsonDecode(profileBody);
  }

  static Future getSentMessages() async {
    var email;
    var profileBody;
    User user = await PrefHandler.getUser();
    print(user.email);
    email = user.email;
    print(email);
    profileBody = await Requests.getRequest(
        "https://floating-badlands-10743.herokuapp.com/api/messages/find_from/$email");
    if (profileBody == false) return [];
    return jsonDecode(profileBody);
  }

  static Future sendMessage(dynamic to, dynamic message) async {
    var email;
    var id;
    var res;
    User user = await PrefHandler.getUser();
    email = user.email;
    id = user.id;
    print(email);
    res = await Requests.postRequest(
        "https://floating-badlands-10743.herokuapp.com/api/messages/new", {
      "from": email,
      "to": to,
      "text": message,
      "vendor_id": id,
    });

    if (res.statusCode != 200) return false;
    return true;
  }

  static dynamic check(dynamic message) {
    if (message == null) return " message cannot be empty!";
    return 1;
  }

  static Future deleteMessage(dynamic id) async {
    var res = await Requests.deleteRequest(
        "https://floating-badlands-10743.herokuapp.com/api/messages/delete/$id");
    return res;
  }
}
