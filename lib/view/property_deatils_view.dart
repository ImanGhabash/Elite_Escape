import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color darkTeal = Color(0xFF285260);
const Color mediumTeal = Color(0xFF5A9C92);
const Color lightAqua = Color(0xFFB4D7D8);
const Color lightBeige = Color(0xFFE0CFBF);
const Color tanBrown = Color(0xFFAA8872);

class PropertyDetailsScreen extends StatelessWidget {
  const PropertyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
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
                stops: [0.0, 0.35, 0.65, 1.0],
              ),
            ),
          ),
          fixedImage(),
          draggableDetails(),
          bookNowButton(),
        ],
      ),
    );
  }
}

Widget fixedImage() {
  return SizedBox(
    height: 600,
    width: double.infinity,
    child: Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              child: Image.asset(
                'assets/images/Untitled.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        favoriteButton(),
      ],
    ),
  );
}

Widget draggableDetails() {
  return DraggableScrollableSheet(
    initialChildSize: 0.45,
    minChildSize: 0.45,
    maxChildSize: 0.9,
    builder: (context, scrollController) {
      return Container(
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
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 200),
          children: [
            basicInfo(),
            const SizedBox(height: 20),
            moreDetails(),
          ],
        ),
      );
    },
  );
}

Widget basicInfo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      InfoIcon(
        Icons.location_on,
        "Malki . Damascus",
        fontSize: 22,
        fontWeight: FontWeight.bold,
        iconSize: 30,
      ),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "\$1,200",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: const [
              Icon(Icons.star, color: Colors.amber, size: 18),
              SizedBox(width: 4),
              Text(
                "4.6",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          InfoIcon(Icons.bed, '5 Bedrooms'),
          InfoIcon(Icons.bathtub, '2 Baths'),
          InfoIcon(Icons.square_foot, '250 sqft'),
        ],
      ),
    ],
  );
}

Widget moreDetails() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text(
        'Description',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 8),
      Text(
        'A modern apartment with natural light and a quiet neighborhood.',
        style: TextStyle(color: Colors.white70),
      ),
      SizedBox(height: 20),
      Text(
        'Gallery',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 10),
      SizedBox(
        height: 90,
        child: _GalleryList(),
      ),
    ],
  );
}

class _GalleryList extends StatelessWidget {
  const _GalleryList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            'https://picsum.photos/200/200?inside=$index',
            width: index == 0 ? 120 : 90,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

Widget bookNowButton() {
  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            mediumTeal,
          ],
        ),
      ),
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkTeal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {},
          child: const Text(
            'Book Now',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

class InfoIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double iconSize;
  final Color iconColor;

  const InfoIcon(
    this.icon,
    this.text, {
    this.textColor = Colors.white,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.iconSize = 18,
    this.iconColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: iconSize, color: iconColor),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}

Widget favoriteButton() {
  return Positioned(
    top: 40,
    right: 20,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(
          Icons.favorite_border,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    ),
  );
}
