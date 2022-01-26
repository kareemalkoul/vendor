import 'dart:convert';
import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/imageuploader.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/requests.dart';

class SaleController {
  static Future getSales() async {
    // User user = await PrefHandler.getUser();
    var id;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;

    var profileBody = await Requests.getRequest(
        "https://floating-badlands-10743.herokuapp.com/api/discounts/vendorDiscounts/${id}");

    if (profileBody == false) return [];
    return jsonDecode(profileBody);
  }

  static Future addSale(dynamic name, dynamic product, dynamic price,
      dynamic expireDate, dynamic expireHour, dynamic expireMinute) async {
    var id;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;

    var res = await Requests.postRequest(
      "https://floating-badlands-10743.herokuapp.com/api/discounts/add_discount",
      {
        "vendor_id": id,
        "value": price * 1.0,
        "expire_date": expireDate,
        "expire_hour": expireHour,
        "expire_minute": expireMinute,
        "product_id": product
      },
    );
  }

  static Future saleEdit(dynamic id, dynamic value) async {
    var res;
    User user = await PrefHandler.getUser();
    print(user);

    res = await Requests.putRequest(
        "https://floating-badlands-10743.herokuapp.com/api/discounts/edit", {
      "id": id,
      "value": value * 1.0,
    });

    return res;
  }

  static Future saleDelete(dynamic id) async {
    var res;
    res = await Requests.deleteRequest(
        "https://floating-badlands-10743.herokuapp.com/api/discounts/delete/$id");

    return res;
  }
}
