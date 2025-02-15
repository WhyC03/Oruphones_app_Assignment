import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<dynamic> _products = [];
  bool _isLoading = false;

  List<dynamic> get products => _products;
  bool get isLoading => _isLoading;

  final String baseUrl = "http://40.90.224.241:5000"; // Change to actual API URL

  // Fetch Products (Already Implemented)
  Future<void> fetchProducts({
    List<String>? conditions,
    List<String>? brands,
    List<int>? priceRange,
    bool verified = false,
    String? sortBy,
    bool ascending = true,
    int page = 1,
  }) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/filter"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "filter": {
            "condition": conditions ?? [],
            "make": brands ?? [],
            "priceRange": priceRange ?? [],
            "verified": verified,
            "sort": sortBy != null ? {sortBy: ascending ? 1 : -1} : {},
            "page": page,
          }
        }),
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        _products = decodedResponse['data']['data'] ?? [];
        notifyListeners();
      } else {
        debugPrint("❌ Failed to fetch products: ${response.body}");
      }
    } catch (e) {
      debugPrint("❌ Error fetching products: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // ✅ Like Product Function
  Future<void> likeProduct(String productId) async {
    final url = Uri.parse("$baseUrl/products/like/$productId");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        debugPrint("❤️ Product liked successfully");

        // Update local product state immediately
        int index = _products.indexWhere((p) => p['listingId'] == productId);
        if (index != -1) {
          _products[index]['isLiked'] = true;
          notifyListeners();
        }
      } else {
        debugPrint("❌ Failed to like product: ${response.body}");
      }
    } catch (e) {
      debugPrint("❌ Error liking product: $e");
    }
  }

  // ✅ Unlike Product Function
  Future<void> unlikeProduct(String productId) async {
    final url = Uri.parse("$baseUrl/products/unlike/$productId");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        debugPrint("💔 Product unliked successfully");

        // Update local product state immediately
        int index = _products.indexWhere((p) => p['listingId'] == productId);
        if (index != -1) {
          _products[index]['isLiked'] = false;
          notifyListeners();
        }
      } else {
        debugPrint("❌ Failed to unlike product: ${response.body}");
      }
    } catch (e) {
      debugPrint("❌ Error unliking product: $e");
    }
  }
}
