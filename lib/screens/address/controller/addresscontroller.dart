import 'dart:convert';

import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/requests.dart';

class AddressController {
  static Future getAddress() async {
    var id;
    var profileBody;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    profileBody = await Requests.getRequest(
        "https://floating-badlands-10743.herokuapp.com/api/locations/find_vendor/$id");
    return jsonDecode(profileBody);
  }

  // static Future getAddressId(dynamic id) async {
  //   var res = await Requests.getRequest(
  //       "https://floating-badlands-10743.herokuapp.com/api/locations/find_user/$id");
  //   return jsonDecode(res);
  // }

  static Future addAddress(dynamic country, dynamic city, dynamic street,
      dynamic nearTo, dynamic name,dynamic type) async {
    var id;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    print(id);
    var res = await Requests.postRequest(
        "https://floating-badlands-10743.herokuapp.com/api/locations/new", {
      "name": name,
      "type": "work",
      "city": city,
      "street": street,
      "country": country,
      "nearto": nearTo,
      "latitude": "2",
      "longitude": "1",
      "vendor_id": id,
      "type":type,
    });
    return res;
  }

  static Future addressEdit(dynamic country, dynamic city, dynamic street,
      dynamic nearTo, dynamic name, dynamic addressId,dynamic type) async {
    var res;
    res = await Requests.putRequest(
        "https://floating-badlands-10743.herokuapp.com/api/locations/edit", {
      "name": name,
      "city": city,
      "street": street,
      "country": country,
      "nearto": nearTo,
      "latitude": "2",
      "longitude": "1",
      "id": addressId,
      "type":type,
    });
    print(res);
    return res;
  }

  static dynamic check(dynamic country, dynamic city, dynamic street,
      dynamic nearTo, dynamic name) {
    if (name == null)
      return "name cannot be empty!";
    else if (country == null)
      return "country cannot be empty!";
    else if (city == null)
      return "city cannot be empty!";
    else if (street == null)
      return "street cannot be empty!";
    else if (nearTo == null)
      return "near to cannot be empty!";
    else
      return 1;
  }
}
