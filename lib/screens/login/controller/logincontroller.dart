import 'package:vendor/requests_handling/requests.dart';
import 'package:vendor/requests_handling/vendor_api.dart';

class LogInController {
  static Future login(dynamic email, dynamic password) async {
    return await Requests.authRequest(
      Vendors.LOGIN,
      {
        "email": email,
        "password": password,
      },
    );
  }

  static dynamic check(dynamic email, dynamic password) {
    if (email == null)
      return "Email cannot be empty!";
    else if (password == null)
      return "Password cannot be empty!";
    else
      return 1;
  }
}
