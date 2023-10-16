import 'dart:convert';

import 'package:ecommerce_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  int userId = 0;
  bool success = false;

  signUp(User user) async {
    final prefs = await SharedPreferences.getInstance();
    // Convert the user to a JSON string ,and save the user to shared prefs
    String userJson = jsonEncode(user.toJson());
    prefs.setString('user', userJson);
  }

  Future<bool> signIn(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = prefs.getString('user') ?? '';
    if (userJson != '') {
      User user = User.fromJson(jsonDecode(userJson));
      if (email == user.email && password == user.password) {
        success = true;
      }
    }
    return success;
  }
}
