import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserLoginProvider {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  getUser() async{
    final SharedPreferences prefs = await _prefs;
    var data = prefs.getString('user');
    if(data != null) return jsonDecode(data);
    return data;
  }

  void setUser(dynamic user) async{
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('user', jsonEncode(user));
    return;
  }

  void logoutUser() async{
    final SharedPreferences prefs = await _prefs;
    await prefs.remove('user');
    return;
  }
}