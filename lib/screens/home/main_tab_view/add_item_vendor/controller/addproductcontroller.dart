import 'dart:convert';

import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/imageuploader.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/requests.dart';

class AddProductController {
  static Future getCat() async {
    var profileBody = await Requests.getRequest(
        "http://floating-badlands-10743.herokuapp.com/api/category/allcategories");

    if (profileBody == false) return [];

    return jsonDecode(profileBody);
  }

  static Future addProduct(dynamic name, dynamic price, dynamic description,
      dynamic quantity, dynamic cat) async {
    var id;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    print(id);

    var res = await Requests.postRequest(
        "https://floating-badlands-10743.herokuapp.com/api/products/new", {
      "name": name,
      "price": price * 1.0,
      "description": description,
      "quantity": quantity,
      "categories": cat,
      "vendor_id": id,
    });
    var body = jsonDecode(res.body);
    var productId = body["id"];
    if (res.statusCode == 200) return productId;
  }

  static Future editProduct(dynamic name, dynamic price, dynamic description,
      dynamic quantity, dynamic productId) async {
    var id;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    print(id);

    var res = await Requests.putRequest(
        "https://floating-badlands-10743.herokuapp.com/api/products/edit", {
      "name": name,
      "price": price,
      "description": description,
      "quantity": quantity,
      //"isComment":4500,
      //"active":4500,
      //"deliverable":4500,
      "vendor_id": id,
      "id": productId,
    });
    var body = jsonDecode(res.body);
    if (res.statusCode == 200) return true;
  }

  static Future addProductImage(dynamic image, dynamic id) async {
    var res = await ImageUploader.uploadImage(
      "https://floating-badlands-10743.herokuapp.com/api/images/new",
      {"product_id": id},
      image,
    );
  }

  static Future deleteProductImage(dynamic id) async {
    var res = await Requests.deleteRequest(
        "https://floating-badlands-10743.herokuapp.com/api/images/delete/$id");
    return res;
  }

  static dynamic check(dynamic name, dynamic price, dynamic quantity) {
    if (name == null)
      return "name cannot be empty!";
    else if (price == null)
      return "country cannot be empty!";
    else if (quantity == null)
      return "city cannot be empty!";
    else
      return 1;
  }
}
