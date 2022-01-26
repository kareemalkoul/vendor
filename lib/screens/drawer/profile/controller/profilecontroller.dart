import 'dart:convert';

import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/imageuploader.dart';
import 'package:vendor/requests_handling/requests.dart';
import 'package:vendor/requests_handling/vendor_api.dart';

class ProfileController {
  static Future profileGet() async {
    var id;
    var profileBody;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    profileBody = await Requests.getRequest(
        "https://floating-badlands-10743.herokuapp.com/api/vendors/find/$id");
    return jsonDecode(profileBody);
  }

  static Future profileEdit(
    dynamic name,
    dynamic slogan,
    dynamic email,
    dynamic password,
    dynamic specification,
    dynamic owner,
    dynamic accountStatus,
  ) async {
    var id;
    var res;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;

    res = await Requests.putRequest(
        "https://floating-badlands-10743.herokuapp.com/api/vendors/edit", {
      "name": name,
      "slogan": slogan,
      "email": email,
      "specification": specification,
      "owner": owner,
      "accountStatus": "pending",
      "id": id
    });

    return res;
  }

  static Future addUserImage(dynamic image) async {
    var id;
    var res;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    res = await ImageUploader.uploadImage(
        "https://floating-badlands-10743.herokuapp.com/api/vendorimage/new",
        {"vendor_id": id},
        image);

    return res;
  }

  static Future addPhone(dynamic number) async {
    var id;
    var res;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    res = await Requests.postRequest(
      Vendors.ADD_PHONE,
      {"number": number, "vendor_id": id, "name": "phone"},
    );

    return res;
  }

  static Future editPhone(dynamic phone, dynamic id) async {
    var id;
    var res;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    res = await Requests.putRequest(
        "https://floating-badlands-10743.herokuapp.com/api/phones/edit", {
      "number": phone,
      "id": id,
    });

    return res;
  }

  static Future editUserImage(dynamic image, dynamic oldImage) async {
    var id;
    var res;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    res = await Requests.deleteRequest(
        "https://floating-badlands-10743.herokuapp.com/api/vendorimage/delete/$oldImage");
    if (res == "succeded")
      res = await ImageUploader.uploadImage(
          "https://floating-badlands-10743.herokuapp.com/api/vendorimage/new",
          {"vendor_id": id},
          image);

    return res;
  }

  static Future phoneGet() async {
    var id;
    var profileBody;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    profileBody = await Requests.getRequest(
        "https://floating-badlands-10743.herokuapp.com/api/phones/find_vendor/$id");
    return jsonDecode(profileBody);
  }

  static dynamic check(
      dynamic name,
      dynamic slogan,
      dynamic email,
      dynamic password,
      dynamic specification,
      dynamic owner,
      dynamic accountStatus) {
    if (name == null)
      return "name cannot be empty!";
    else if (slogan == null)
      return "slogan cannot be empty!";
    else if (email == null)
      return "Email cannot be empty!";
    else if (specification == null)
      return "specification cannot be empty!";
    else if (owner == null)
      return "Gender cannot be empty!";
    else
      return 1;
  }

  static Future profileDelete() async {
    var id;
    var profileBody;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    profileBody = await Requests.deleteRequest(
        "https://floating-badlands-10743.herokuapp.com/api/vendors/delete/$id");
    return jsonDecode(profileBody);
  }
}
