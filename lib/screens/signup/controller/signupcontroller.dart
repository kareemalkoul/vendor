import 'package:vendor/models/user.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/requests.dart';
import 'package:vendor/requests_handling/vendor_api.dart';

class SignUpController {
  static Future signup(
      dynamic name,
      dynamic slogan,
      dynamic email,
      dynamic password,
      dynamic specification,
      dynamic owner,
      dynamic accountStatus,
      dynamic code) async {
    if (await Requests.authRequest(
      Vendors.REGISTERATION,
      {
        "name": name,
        "slogan": slogan,
        "email": email,
        "password": password,
        "specification": specification,
        "owner": owner,
        "accountStatus": "pending",
      },
    )) {
      return await addCode(code);
    } else {
      return false;
    }
  }

  static Future addCode(String code) async {
    var id;
    var res;
    User user = await PrefHandler.getUser();
    id = user.id;
    res = await Requests.postRequest(
      "https://floating-badlands-10743.herokuapp.com/api/reset/new",
      {
        "vendor_id": id,
        "code": code,
      },
    );

    if (res.statusCode != 200) return false;
    return true;
  }

  static dynamic check(
      dynamic name,
      dynamic slogan,
      String email,
      String password,
      dynamic specification,
      dynamic owner,
      dynamic accountStatus,
      dynamic code) {
    print("email fff $email");
    if (name == null || name == "")
      return "name cannot be empty!";
    else if (slogan == null || slogan == "")
      return "slogan cannot be empty!";
    else if (email == null || email == "")
      return "Email cannot be empty!";
    else if (!checkIsEmail(email))
      return "Email not correct !";
    else if (password == null || password == "")
      return "Password cannot be empty!";
    else if (password.length < 8)
      return "Password cannot be less than 8 char !";
    else if (specification == null || specification == "")
      return "specification cannot be empty!";
    else if (owner == null || owner == "")
      return "owner cannot be empty!";
    else if (code == null || code == "")
      return "code cannot be empty!";
    else
      return 1;
  }

  static bool checkIsEmail(String email) {
    var p =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    return RegExp(p).hasMatch(email);
  }
}
