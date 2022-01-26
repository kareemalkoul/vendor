import 'package:http/http.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'headers.dart';
import 'dart:convert';
import 'package:vendor/models/user.dart';

class Requests {
  static Future authRequest(String url, Map<String, dynamic> body) async {
    var uri = Uri.parse(url);
    Response response;
    bool res;
    print("authrequest");
    try {
      response =
          await post(uri, body: jsonEncode(body), headers: Headers.authHeaders);
    } catch (e) {
      print(e);
    }
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      res = true;
    } else {
      return false;
    }

    var userMap = jsonDecode(response.body);
    User user = User.fromJson(userMap);
    await PrefHandler.saveUser(user);
    var token = response.headers['x-auth-token'];
    print(token);
    await PrefHandler.saveToken(token);
    return res;
  }

  static Future postRequest(String url, Map<String, dynamic> body) async {
    var token = await PrefHandler.getToken();
    var uri = Uri.parse(url);
    Response response;
    try {
      response = await post(uri,
          body: jsonEncode(body), headers: Headers.reqHeaders(token));
    } catch (e) {
      print(e);
    }
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
  }

  static Future putRequest(String url, Map<String, dynamic> body) async {
    var token = await PrefHandler.getToken();
    var uri = Uri.parse(url);
    Response response;
    try {
      response = await put(uri,
          body: jsonEncode(body), headers: Headers.reqHeaders(token));
    } catch (e) {
      print(e);
    }
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
  }

  static Future getRequest(String url) async {
    var token = await PrefHandler.getToken();
    var uri = Uri.parse(url);
    Response response;
    try {
      response = await get(uri, headers: Headers.reqHeaders(token));
    } catch (e) {
      print(e);
    }
    //print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    prettyPrintJson(response.body);
    if (response.statusCode != 200) return false;
    return response.body;
  }

  static Future deleteRequest(String url) async {
    var token = await PrefHandler.getToken();
    var uri = Uri.parse(url);
    Response response = await delete(uri, headers: Headers.reqHeaders(token));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode != 200) return false;
    return response.body;
  }

  static List<String> errors = [];

  bool handleResponse(final response) {
    bool s = true;
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      errors.clear();
    }
    switch (response.statusCode) {
      case 200:
        errors.clear();
        break;
      case 400:
        {
          errors.add("you should fill all the fields first !");
          s = false;
        }
        break;
      case 401:
        {
          errors.add("Unauthorized ! you have to log in again");
          s = false;
        }
        break;
      case 403:
        {
          errors.add("you can't do that right now");
        }
        break;
      case 404:
        {
          errors.add("what are tou looking for does not exist");
        }
        break;
      case 500:
        {
          errors.add("server error try again later !");
        }
        break;
      case 503:
        {
          errors.add("the requested service is not available");
        }
        break;
      default:
        {
          errors.add("soee thing went wrong !");
        }
        break;
    }
    return s;
  }
}

void prettyPrintJson(String input) {
  const JsonDecoder decoder = JsonDecoder();
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final dynamic object = decoder.convert(input);
  final dynamic prettyString = encoder.convert(object);
  prettyString.split('\n').forEach((dynamic element) => print(element));
}
