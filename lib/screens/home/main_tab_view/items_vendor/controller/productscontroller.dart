import 'dart:convert';

import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/requests.dart';
import 'package:vendor/requests_handling/vendor_api.dart';

class ProductsController {
  static Future deleteProduct(dynamic id) async {
    var profileBody;

    profileBody = await Requests.deleteRequest(
        "https://floating-badlands-10743.herokuapp.com/api/products/delete/$id");
    return profileBody;
  }

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

  static Future addDicount(dynamic id, dynamic value, dynamic dateBegin,
      dynamic dateEnd, int hour, int minute) async {
    var profileBody;

    print({
      "value": value,
      "date_of_discount": dateBegin,
      "expire_date": dateEnd,
      "expire_hour": 23,
      "expire_minute": 0,
      "product_id": id
    });
    profileBody = await Requests.postRequest(Vendors.ADD_DISCOUNT, {
      "value": value,
      "date_of_discount": dateBegin,
      "expire_date": dateEnd,
      "expire_hour": 23,
      "expire_minute": 0,
      "product_id": id
    });
    if (profileBody.body is String) {
      return profileBody.body;
    } else
      return jsonDecode(profileBody.body);
  }
}
