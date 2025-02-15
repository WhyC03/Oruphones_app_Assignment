// ignore_for_file: dead_code, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  AuthProvider() {
    _loadLoginStatus();
  }

  Future<void> _loadLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final hasUserName = prefs.getString('userName') != null;
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false && hasUserName;
    notifyListeners();
  }

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userName');
    await prefs.remove('csrfToken');
    await prefs.remove('sessionCookie');
    _isLoggedIn = false;
    notifyListeners();
    Navigator.pushReplacementNamed(context, '/home');
  }
}
