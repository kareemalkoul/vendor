import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/requests.dart';

class HomeController {
  static Future subsAll(dynamic token) async {
    var res = await Requests.postRequest(
        "https://floating-badlands-10743.herokuapp.com/api/notifications/follow",
        {"registrationTokens": token, "topic": "news"});
  }

  static Future postToken(dynamic token) async {
    var id;
    User user = await PrefHandler.getUser();
    print(user);
    id = user.id;
    var res = await Requests.putRequest(
        "https://floating-badlands-10743.herokuapp.com/api/vendors/token",
        {"token": token, "id": id});
  }
}
