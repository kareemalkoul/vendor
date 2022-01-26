// import 'dart:convert';
// import 'package:vendor/models/user.dart';
// import 'package:vendor/requests_handling/imageuploader.dart';
// import 'package:vendor/requests_handling/prefhalndler.dart';
// import 'package:vendor/requests_handling/requests.dart';

// class OfferController {
//   static Future getOffer() async {
//     // User user = await PrefHandler.getUser();
//     var id;
//     User user = await PrefHandler.getUser();
//     print(user);
//     id = user.id;

//     var profileBody = await Requests.getRequest(
//         "https://floating-badlands-10743.herokuapp.com/api/offers/vendorOffer/${id}");

//     if (profileBody == false) return [];
//     return jsonDecode(profileBody);
//   }

//   static Future addOffer(
//       dynamic image,
//       dynamic name,
//       dynamic products,
//       dynamic price,
//       dynamic expireDate,
//       dynamic expireHour,
//       dynamic expireMinute) async {
//     print("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
//     print(image.toString());
//     print(name.toString());
//     print(products.length.toString());
//     print(price.toString());
//     print(expireDate);
//     print(expireHour);
//     print(expireMinute);
//     print(image);
//     print("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
//     var id;
//     User user = await PrefHandler.getUser();
//     print(user);
//     print("ids" + "$products");

//     id = user.id;
//     print({
//       "vendor_id": id,
//       "price": price,
//       "expire_date": expireDate,
//       "expire_hour": expireHour,
//       "expire_minute": expireMinute,
//       "status": "active",
//       "products": products
//     });
//     var res = await ImageUploader.uploadImage(
//         "https://floating-badlands-10743.herokuapp.com/api/offers/new",
//         {
//           "name": name,
//           "vendor_id": id,
//           "price": price,
//           "expire_date": expireDate,
//           "expire_hour": expireHour,
//           "expire_minute": expireMinute,
//           "status": "active",
//           "products": products
//         },
//         image);
//   }

//   static Future OfferEdit(dynamic price, dynamic id) async {
//     var res;
//     User user = await PrefHandler.getUser();

//     res = await Requests.putRequest(
//         "https://floating-badlands-10743.herokuapp.com/api/offers/edit/$id", {
//       "price": price,
//     });

//     return res;
//   }

//   static Future Offerdelete(dynamic id) async {
//     var res;
//     res = await Requests.deleteRequest(
//         "https://floating-badlands-10743.herokuapp.com/api/offers/deleteoffer/$id");

//     return res;
//   }
// }

import 'dart:convert';
import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/imageuploader.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/requests.dart';

class OfferController {
  static Future getOffer() async {
    // User user = await PrefHandler.getUser();
    var id;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;

    var profileBody = await Requests.getRequest(
        "https://floating-badlands-10743.herokuapp.com/api/offers/vendorOffer/${id}");

    if (profileBody == false) return [];
    return jsonDecode(profileBody);
  }

  static Future addOffer(
      dynamic image,
      dynamic name,
      dynamic products,
      dynamic price,
      dynamic expireDate,
      dynamic expireHour,
      dynamic expireMinute) async {
    print("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
    var id;
    User user = await PrefHandler.getUser();
    print(user);
    print("ids" + "$products");

    id = user.id;
    print({
      "vendor_id": id,
      "price": price,
      "expire_date": expireDate,
      "expire_hour": expireHour,
      "expire_minute": expireMinute,
      "status": "active",
      "products": products
    });
    var res = await Requests.postRequest(
      "https://floating-badlands-10743.herokuapp.com/api/offers/newoffer",
      {
        "name": name,
        "vendor_id": id,
        "price": price * 1.0,
        "expire_date": expireDate,
        "expire_hour": expireHour,
        "expire_minute": expireMinute,
        "status": "active",
        "products": products
      },
    );

    var offerId;
    var body;

    if (res.statusCode == 200) {
      body = jsonDecode(res.body);
      offerId = body["id"];
      var temp = await ImageUploader.uploadImage(
          "https://floating-badlands-10743.herokuapp.com/api/offers/newimage",
          {
            "id": offerId,
          },
          image);
    }
  }

  static Future OfferEdit(dynamic price, dynamic id) async {
    var res;
    User user = await PrefHandler.getUser();

    res = await Requests.putRequest(
        "https://floating-badlands-10743.herokuapp.com/api/offers/edit/$id", {
      "price": price * 1.0,
    });

    return res;
  }

  static Future Offerdelete(dynamic id) async {
    var res;
    res = await Requests.deleteRequest(
        "https://floating-badlands-10743.herokuapp.com/api/offers/deleteoffer/$id");

    return res;
  }
}
