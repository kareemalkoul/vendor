import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/models/user.dart';
import 'dart:convert';

class PrefHandler {
  static final PrefHandler _instanse = PrefHandler._internal();
  SharedPreferences prefs;

  factory PrefHandler() {
    return _instanse;
  }

  PrefHandler._internal();

  void init(SharedPreferences prefs) async {
    this.prefs = prefs;
  }

  static Future getUser() async {
    var userMap;
    User user;

    final String userStr = _instanse.prefs.getString('user');
    if (userStr != null) {
      userMap = jsonDecode(userStr) as Map<String, dynamic>;
      user = User.fromJson(userMap);
    }
    print(user.email);
    return user;
  }

  static Future saveUser(User user) async {
    bool result = await _instanse.prefs.setString('user', jsonEncode(user));
    bool result2 = await _instanse.prefs.setInt('isLogged', 1);
  }

  static Future getToken() async {
    final String token = _instanse.prefs.getString('token');
    if (token != null) {
      print(token);
      return token;
    }
  }

  static Future saveToken(String token) async {
    bool result = await _instanse.prefs.setString('token', token);
  }
}

class PrefHandler1 {
  static Future getUser() async {
    var userMap;
    User user;
    SharedPreferences prefs;
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print(e);
    }
    final String userStr = prefs.getString('user');
    if (userStr != null) {
      userMap = jsonDecode(userStr) as Map<String, dynamic>;
      user = User.fromJson(userMap);
    }
    print(user.email);
    return user;
  }

  static Future saveUser(User user) async {
    SharedPreferences prefs;
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print(e);
    }
    bool result = await prefs.setString('user', jsonEncode(user));
    bool result2 = await prefs.setInt('isLogged', 1);
  }

  static Future getToken() async {
    SharedPreferences prefs;
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print(e);
    }
    final String token = prefs.getString('token');
    if (token != null) {
      print(token);
      return token;
    }
  }

  static Future saveToken(String token) async {
    SharedPreferences prefs;

    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print(e);
    }
    bool result = await prefs.setString('token', token);
  }
}
