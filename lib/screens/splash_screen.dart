// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool("isLoggedIn");
    String? userName = prefs.getString("userName");
    String? csrfToken = prefs.getString("csrfToken");
    String? sessionCookie = prefs.getString("sessionCookie");

    debugPrint("SplashScreen: isLoggedIn = $isLoggedIn");
    debugPrint("SplashScreen: userName = $userName");
    debugPrint("SplashScreen: csrfToken = $csrfToken");
    debugPrint("SplashScreen: sessionCookie = $sessionCookie");

    await Future.delayed(Duration(seconds: 3, milliseconds: 500));

    Navigator.pushReplacementNamed(context, "/home");
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => ProductListScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/Splash.json',
          width: 300,
          height: 500,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
