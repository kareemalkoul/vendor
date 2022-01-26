import 'dart:convert';
import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';

import 'package:vendor/requests_handling/requests.dart';

class PasswordController {
  static Future resetPassword(
      String email, String code, String newPassword) async {
    var res = await Requests.postRequest(
        "https://floating-badlands-10743.herokuapp.com/api/reset/resetvendor", {
      "email": email,
      "code": code,
      "newpassword": newPassword,
    });

    return jsonDecode(res.body);
  }

  static Future checkPassword(String password) async {
    var id;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    print(id);

    var res = await Requests.postRequest(
      "https://floating-badlands-10743.herokuapp.com/api/reset/checkvendor",
      {
        "vendor_id": id,
        "password": password,
      },
    );

    return jsonDecode(res.body);
  }

  static Future changekPassword(String newpassword) async {
    var id;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    print(id);

    var res = await Requests.postRequest(
      "https://floating-badlands-10743.herokuapp.com/api/reset/changevendor",
      {
        "vendor_id": id,
        "newpassword": newpassword,
      },
    );

    return jsonDecode(res.body);
  }
}
