import 'dart:convert';

import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/requests.dart';
import 'package:vendor/requests_handling/vendor_api.dart';

class HomeController {
  static Future getSales() async {
    var id;
    var profileBody;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    profileBody = await Requests.getRequest(
        "https://floating-badlands-10743.herokuapp.com/api/orders/vendor_sales/$id");
    return jsonDecode(profileBody);
  }

  static Future getMoney() async {
    var id;
    var profileBody;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    profileBody = await Requests.getRequest(
        "http://floating-badlands-10743.herokuapp.com/api/orders/vendor_money/$id");
    return jsonDecode(profileBody);
  }

  static Future getDaily(int day, int month, int year) async {
    var userid;
    var profileBody;
    User user = await PrefHandler.getUser();
    print(user);
    userid = user.id;
    profileBody = await Requests.getRequest(
        "https://floating-badlands-10743.herokuapp.com/api/home/vendorhome/$userid/$day/$month/$year");
    return jsonDecode(profileBody);
  }

  static Future getWeakly() async {
    DateTime dateTime = DateTime.now();

    List<int> list = [];
    int day, month, year;
    int sum;
    for (int i = 0; i < 7; i++) {
      dateTime.subtract(Duration(days: i));
      day = dateTime.day;
      month = dateTime.month;
      year = dateTime.year;
      sum = (await getDaily(day, month, year))["sum"].floor();
      list.add(sum);
    }

    return list;
  }
}
