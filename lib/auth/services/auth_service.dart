// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = "http://40.90.224.241:5000";

  // Function to send OTP
  Future<void> sendOtp(String phoneNumber) async {
    final url = Uri.parse("$baseUrl/login/otpCreate");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "countryCode": 91,
        "mobileNumber": int.parse(phoneNumber),
      }),
    );

    log(response.body);
    if (response.statusCode == 200) {
      debugPrint("OTP sent successfully.");
    } else {
      debugPrint("Failed to send OTP: ${response.body}");
    }
  }

  // Function to verify OTP & store session cookies
  Future<bool> verifyOtp(String phoneNumber, String otp, BuildContext context) async {
    final url = Uri.parse("$baseUrl/login/otpValidate");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "countryCode": 91,
        "mobileNumber": int.parse(phoneNumber),
        "otp": int.parse(otp),
      }),
    );

    log("OTP Verification Response: ${response.body}");

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", true);

      // ✅ Store session cookie
      if (response.headers.containsKey("set-cookie")) {
        String? sessionCookie = response.headers["set-cookie"];
        if (sessionCookie != null) {
          await prefs.setString("sessionCookie", sessionCookie);
          debugPrint("Session Cookie stored: $sessionCookie");
        }
      }

      // ✅ Fetch CSRF Token
      bool csrfFetched = await fetchCsrfToken();
      if (!csrfFetched) {
        debugPrint("Failed to fetch authentication data.");
        return false;
      }

      // Check if username exists
      String? userName = prefs.getString("userName");
      if (userName != null && userName.isNotEmpty) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/username");
      }
      return true;
    } else {
      debugPrint("OTP verification failed: ${response.body}");
      return false;
    }
  }

  // Fetch CSRF Token & Send Session Cookie
  Future<bool> fetchCsrfToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sessionCookie = prefs.getString("sessionCookie");

    final url = Uri.parse("$baseUrl/isLoggedIn");

    final response = await http.get(
      url,
      headers: {
        "Cookie": sessionCookie ?? "", // ✅ Send stored session cookie
      },
    );

    log("CSRF Fetch Response: ${response.body}");

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse["isLoggedIn"] == false) {
        debugPrint("User is NOT logged in. Invalid session.");
        return false;
      }

      // ✅ Save CSRF Token
      String csrfToken = jsonResponse["csrfToken"];
      await prefs.setString("csrfToken", csrfToken);

      debugPrint("CSRF Token stored: $csrfToken");
      return true;
    } else {
      debugPrint("Failed to fetch CSRF Token: ${response.body}");
      return false;
    }
  }

  // Function to update the user's name
  Future<bool> updateUserName(String name, BuildContext context) async {
    final url = Uri.parse("$baseUrl/update");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? csrfToken = prefs.getString("csrfToken");
    String? sessionCookie = prefs.getString("sessionCookie");

    if (csrfToken == null || sessionCookie == null) {
      debugPrint("CSRF Token or Session Cookie missing. Re-fetching...");
      bool tokenFetched = await fetchCsrfToken();
      if (!tokenFetched) {
        debugPrint("Authentication fetch failed.");
        return false;
      }
      csrfToken = prefs.getString("csrfToken");
      sessionCookie = prefs.getString("sessionCookie");
    }

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "X-Csrf-Token": csrfToken ?? "",
        "Cookie": sessionCookie ?? "", // ✅ Send session cookie
      },
      body: jsonEncode({
        "countryCode": 91,
        "userName": name,
      }),
    );

    log("Update Name Response: ${response.body}");

    if (response.statusCode == 200) {
      await prefs.setString("userName", name);
      debugPrint("User name updated successfully.");
      Navigator.pushReplacementNamed(context, "/home");
      return true;
    } else {
      debugPrint("Failed to update user name: ${response.body}");
      return false;
    }
  }

  // Function to get the stored user name
  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userName");
  }
}
