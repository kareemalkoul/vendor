import 'dart:convert';

import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/requests.dart';

class MessagesController {
  static Future getMessages() async {
    var id;
    var profileBody;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    profileBody = await Requests.getRequest(
        "https://floating-badlands-10743.herokuapp.com/api/responses/find_vendor/$id");

    if (profileBody == false) return [];
    return jsonDecode(profileBody);
  }
}
