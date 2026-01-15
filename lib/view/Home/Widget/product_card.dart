import 'package:flutter/material.dart';
import 'package:task/models/apartment_model.dart';
import 'package:task/view/property_deatils_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PropertyDetailsScreen(apartment: product),
          ),
        );
      },
      child: Container(
  width: double.infinity,
  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10),

      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: ImageUtils.fixImageUrl(product.imageUrl),
          height: 180,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),



      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          product.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),

      // const SizedBox(height: 6),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        // child: Text(
        //   "\$${product.dailyPrice.toStringAsFixed(2)} / night - ${product.numberOfRooms} Rooms",
        //   style: const TextStyle(
        //     fontSize: 14,
        //     color: Colors.grey,
        //   ),
        // ),
      ),

      // const SizedBox(height: 12),
    ],
  ),
),

    );
  }
}

class ImageUtils {
  static String fixImageUrl(String url) {
    if (url.contains('localhost')) {
      return url.replaceAll('localhost', '10.0.2.2:8000');
    }
    return url;
  }
}
