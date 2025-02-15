// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:oruphones_app/providers/auth_provider.dart';

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
  Future<bool> verifyOtp(
      String phoneNumber, String otp, BuildContext context) async {
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

      if (response.headers.containsKey("set-cookie")) {
        String? sessionCookie = response.headers["set-cookie"];
        if (sessionCookie != null) {
          await prefs.setString("sessionCookie", sessionCookie);
          debugPrint("Session Cookie stored: $sessionCookie");
        }
      }

      bool csrfFetched = await fetchCsrfToken();
      if (!csrfFetched) {
        debugPrint("Failed to fetch authentication data.");
        return false;
      }
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

  Future<bool> fetchCsrfToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sessionCookie = prefs.getString("sessionCookie");

    final url = Uri.parse("$baseUrl/isLoggedIn");

    final response = await http.get(
      url,
      headers: {
        "Cookie": sessionCookie ?? "",
      },
    );

    log("CSRF Fetch Response: ${response.body}");

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse["isLoggedIn"] == false) {
        debugPrint("User is NOT logged in. Invalid session.");
        return false;
      }

      String csrfToken = jsonResponse["csrfToken"];
      await prefs.setString("csrfToken", csrfToken);

      debugPrint("CSRF Token stored: $csrfToken");
      return true;
    } else {
      debugPrint("Failed to fetch CSRF Token: ${response.body}");
      return false;
    }
  }

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
        "Cookie": sessionCookie ?? "",
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

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userName");
  }

  //Logout Function
  Future<void> logout(BuildContext context) async {
    final url = Uri.parse("$baseUrl/logout");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? csrfToken = prefs.getString("csrfToken");
    String? sessionCookie = prefs.getString("sessionCookie");

    final response = await http.get(
      url,
      headers: {
        "X-Csrf-Token": csrfToken ?? "",
        "Cookie": sessionCookie ?? "",
      },
    );

    if (response.statusCode == 200) {
      debugPrint("User logged out successfully.");

      Icon(Icons.notifications_on_outlined);
      await prefs.remove("isLoggedIn");
      await prefs.remove("userName");
      await prefs.remove("csrfToken");
      await prefs.remove("sessionCookie");

      // Update AuthProvider state
      Provider.of<AuthProvider>(context, listen: false).logout(context);
    } else {
      debugPrint("Failed to log out: ${response.body}");
    }
  }

  // Fetch products with filters
  Future<List<dynamic>> fetchProducts({
    List<String>? condition,
    List<String>? brand,
    List<int>? priceRange,
    bool verified = false,
    String? sortBy,
    bool ascending = true,
    int page = 1,
    List<String>? storageOptions,
    List<String>? ramOptions,
    List<String>? warranties,
  }) async {
    final String baseUrl = "http://40.90.224.241:5000";
    final url = Uri.parse("$baseUrl/filter");

    log("Sending request to API: $url");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "filter": {
          "condition": condition ?? [],
          "make": brand ?? [],
          "priceRange": priceRange ?? [],
          "verified": verified,
          "sort": sortBy != null ? {sortBy: ascending ? 1 : -1} : {},
          "page": page,
        }
      }),
    );

    log("API Response Status: ${response.statusCode}");

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      // log("Full API Response: $decodedResponse");

      if (decodedResponse is Map && decodedResponse.containsKey('data')) {
        final List<dynamic> productList =
            decodedResponse['data']['data']; // 🔥 FIXED: Extract nested data
        // log("Extracted ${productList.length} products.");
        return productList;
      } else {
        log("Unexpected API response format.");
        return [];
      }
    } else {
      log("API Error: ${response.body}");
      throw Exception("Failed to fetch products");
    }
  }

  // Like a product
  Future<bool> likeProduct(String productId) async {
    return _toggleLike(productId, isLiking: true);
  }

  // Unlike a product
  Future<bool> unlikeProduct(String productId) async {
    return _toggleLike(productId, isLiking: false);
  }

  // Common Like/Unlike function
  Future<bool> _toggleLike(String productId, {required bool isLiking}) async {
    final url =
        Uri.parse("http://40.90.224.241:5000/favs"); // Corrected endpoint

    log("Sending ${isLiking ? 'Like' : 'Unlike'} Request to: $url with ID: $productId");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? csrfToken = prefs.getString("csrfToken");
    String? sessionCookie = prefs.getString("sessionCookie");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "X-Csrf-Token": csrfToken ?? "",
          "Cookie": sessionCookie ?? "",
        },
        body: jsonEncode({
          "listingId": productId,
          "isFav": isLiking // Correct field name
        }),
      );

      if (response.statusCode == 200) {
        debugPrint("Product ${isLiking ? 'liked' : 'unliked'} successfully");
        return true;
      } else {
        debugPrint(
            "Failed to ${isLiking ? 'like' : 'unlike'} product: ${response.body}");
        return false;
      }
    } catch (e) {
      debugPrint("Error ${isLiking ? 'liking' : 'unliking'} product: $e");
      return false;
    }
  }

  // Get liked products
  Future<List<dynamic>> getLikedProducts() async {
    final url = Uri.parse("$baseUrl/products/liked");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sessionCookie = prefs.getString("sessionCookie");

    try {
      final response = await http.get(
        url,
        headers: {
          "Cookie": sessionCookie ?? "",
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse['likedProducts'] ?? [];
      } else {
        debugPrint("Failed to fetch liked products: ${response.body}");
        return [];
      }
    } catch (e) {
      debugPrint(" Error fetching liked products: $e");
      return [];
    }
  }
}
