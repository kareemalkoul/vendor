import 'dart:convert';

import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/requests.dart';

class ProductsController {
  static Future getProducts() async {
    var id;
    var profileBody;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    profileBody = await Requests.getRequest(
        "https://floating-badlands-10743.herokuapp.com/api/products/find_vendor/$id");
    return jsonDecode(profileBody);
  }
}
