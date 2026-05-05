
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


class UserProvider extends ChangeNotifier {
  String _username = '';
 String _useremail='';

  String get username => _username;
  String get useremail=>_useremail;

  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username') ?? '';
    _useremail=prefs.getString('useremail')??'';
    notifyListeners();
  }

  Future<void> setUser(String name,String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    await prefs.setString('useremail', email);
    _useremail=email;
    _username = name;
    notifyListeners();
  }
 Future<void> clearUser() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.remove('username');
  await prefs.remove('useremail');

  _username = '';
  _useremail = '';

  notifyListeners();
}
Future<void> logout() async {
    await clearUser();
  
  }
}
