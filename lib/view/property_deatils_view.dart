import 'package:flutter/material.dart';
import 'package:task/models/product.dart';
import 'package:task/view/booking.dart';


const Color darkTeal = Color(0xFF285260);
const Color mediumTeal = Color(0xFF5A9C92);
const Color lightAqua = Color(0xFFB4D7D8);
const Color tanBrown = Color(0xFFAA8872);

class PropertyDetailsScreen extends StatelessWidget {
  final Product product;

  const PropertyDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _background(),
_imageSection(context),        
  _detailsSection(),
          _bookNowButton(context),
        ],
      ),
    );
  }

  /* ---------------- BACKGROUND ---------------- */

  Widget _background() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            darkTeal,
            mediumTeal,
            lightAqua,
            tanBrown,
          ],
        ),
      ),
    );
  }

  /* ---------------- IMAGE ---------------- */

 Widget _imageSection(BuildContext context) {
  return SizedBox(
    height: 550,
    width: double.infinity,
    child: Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Image.asset(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        _favoriteButton(),
        _backButton(context),
      ],
    ),
  );
}

  /* ---------------- DETAILS ---------------- */

  Widget _detailsSection() {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.45,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                mediumTeal,
                lightAqua,
                tanBrown,
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              _titleAndRate(),
              const SizedBox(height: 12),
              _priceAndReviews(),
              const SizedBox(height: 20),
              _description(),
            ],
          ),
        );
      },
    );
  }

  Widget _titleAndRate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            product.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 18),
            const SizedBox(width: 4),
            Text(
              product.rate.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _priceAndReviews() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "\$${product.price}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          product.review,
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }

  /* ---------------- BUTTONS ---------------- */

 Widget _bookNowButton(BuildContext context) {
  return Positioned(
    bottom: 20,
    left: 16,
    right: 16,
    child: SizedBox(
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkTeal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Booking(
                // هنا ممكن تمرر اسم الشقة أو أي بيانات مهمة
                // apartmentName: product.title
              ),
            ),
          );
        },
        child: const Text(
          'Book Now',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    ),
  );
}


  Widget _favoriteButton() {
    return Positioned(
      top: 40,
      right: 20,
      child: CircleAvatar(
        backgroundColor: Colors.black45,
        child: IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.white),
          onPressed: () {},
        ),
      ),
    );
  }

Widget _backButton(BuildContext context) {
  return Positioned(
    top: 40,
    left: 20,
    child: CircleAvatar(
      backgroundColor: Colors.black45,
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    ),
  );
}}