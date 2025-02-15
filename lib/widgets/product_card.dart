// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();
    bool isLiked = product['isLiked'] ?? false;
    String productId = product['listingId'];

    bool isVerified = product['verified'] ?? false;
    String productName = product['marketingName'] ?? 'Unknown Model';

    // Convert values safely
    int listingPrice = int.tryParse(product['listingPrice'].toString()) ?? 0;
    int originalPrice = int.tryParse(product['originalPrice'].toString()) ?? 0;
    double discountPercentage =
        double.tryParse(product['discountPercentage'].toString()) ?? 0.0;

    String storage = product['deviceStorage'] ?? '--';
    String condition = product['deviceCondition'] ?? 'N/A';
    String location = product['listingLocation'] ?? 'Unknown';
    String date = product['listingDate'] ?? '';

    String imageUrl = product['defaultImage']?['fullImage'] ??
        'https://via.placeholder.com/150'; // Default image if missing

    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Stack(
                    children: [
                      Image.network(
                        imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(Icons.phone_android, size: 80),
                        ),
                      ),

                      // Verified Badge
                      if (isVerified)
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              "ORU Verified",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),

                      // Price Negotiable Label
                      if (product['openForNegotiation'] == true)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            color: Colors.black.withOpacity(0.6),
                            alignment: Alignment.center,
                            child: Text(
                              "PRICE NEGOTIABLE",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Product Details
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "$storage • $condition",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(height: 4),

                    // Price Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              '₹$listingPrice',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            if (originalPrice > 0) ...[
                              Text(
                                '₹$originalPrice',
                                style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 14,
                                ),
                              ),
                            ]
                          ],
                        ),
                        SizedBox(width: 5),
                        if (originalPrice > 0) ...[
                          Text(
                            "(${discountPercentage.toStringAsFixed(1)}% off)",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 4),

                    Row(
                      children: [
                        Text(
                          location,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(width: 10),
                        Text(
                          date,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Favorite Icon (Top Right)
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                if (isLiked) {
                  productProvider.unlikeProduct(productId);
                } else {
                  productProvider.likeProduct(productId);
                }
              },
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.grey,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
