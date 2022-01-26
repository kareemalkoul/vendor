import 'dart:convert';

import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/requests.dart';
class PhonesController {
  static Future getPhones() async {
    var id;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    var res = await Requests.getRequest(
        "https://floating-badlands-10743.herokuapp.com/api/phones/find_vendor/$id");

    if (res == false) return [];
    return jsonDecode(res);
  }

  static Future addPhone(dynamic phone, dynamic name) async {
    var id;
    var res;
    User user = await PrefHandler.getUser();
    id = user.id;
    res = await Requests.postRequest(
        "https://floating-badlands-10743.herokuapp.com/api/phones/new", {
      "number": phone,
      "vendor_id": id,
      "name": name,
    });

    if (res.statusCode != 200) return false;
    return true;
  }

  static Future editPhone(dynamic phone, dynamic phoneId, dynamic name) async {
    var res;
    res = await Requests.putRequest(
        "https://floating-badlands-10743.herokuapp.com/api/phones/edit", {
      "number": phone,
      "id": phoneId,
      "name": name,
    });

    if (res.statusCode != 200) return false;
    return true;
  }

  static Future deletePhone(dynamic id) async {
    var res = await Requests.deleteRequest(
        "https://floating-badlands-10743.herokuapp.com/api/phones/delete/$id");
    return res;
  }
}
