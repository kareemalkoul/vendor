import 'dart:convert';

import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/requests.dart';

class ReportController {
  static Future reportProblem(
    dynamic problem,
  ) async {
    var id;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    print(id);

    var res = await Requests.postRequest(
        "https://floating-badlands-10743.herokuapp.com/api/problems/new", {
      "problem": problem,
      "vendor_id": id,
    });
    var body = jsonDecode(res.body);
    if (res.statusCode == 200) return body;
  }
}
