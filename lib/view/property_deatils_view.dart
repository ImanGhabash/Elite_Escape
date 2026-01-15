import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/controllers/favorite_controller.dart';
import 'package:task/models/apartment_model.dart';
import 'package:task/view/Home/Widget/product_card.dart';
import 'package:task/view/booking.dart';
// import 'package:task/models/product.dart';
// import 'package:task/view/booking.dart';

const Color darkTeal = Color(0xFF285260);
const Color mediumTeal = Color(0xFF5A9C92);
const Color lightAqua = Color(0xFFB4D7D8);
const Color tanBrown = Color(0xFFAA8872);

class PropertyDetailsScreen extends ConsumerWidget {
  final Product apartment;

  const PropertyDetailsScreen({
    super.key,
    required this.apartment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          _background(),
          _imageSection(context, ref),
          _detailsSection(),
          _bookNowButton(context, apartment),
        ],
      ),
    );
  }

  Widget _background() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [darkTeal, mediumTeal, lightAqua, tanBrown],
        ),
      ),
    );
  }

  Widget _imageSection(BuildContext context, WidgetRef ref) {
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
                child: CachedNetworkImage(
                  imageUrl: apartment.imageUrl.isNotEmpty
                      ? ImageUtils.fixImageUrl(apartment.imageUrl)
                      : 'https://placehold.co/600x400/888888/CCCCCC.png',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _favoriteButton(ref),
          _backButton(context),
        ],
      ),
    );
  }

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
              colors: [mediumTeal, lightAqua, tanBrown],
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
              _priceAndRooms(),
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
            apartment.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Row(
        //   children: [
        //     const Icon(Icons.star, color: Colors.amber, size: 18),
        //     const SizedBox(width: 4),
        //     Text(
        //       apartment.rate != null ? apartment.rate.toString() : '0',
        //       style: const TextStyle(
        //         color: Colors.white,
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget _priceAndRooms() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "\$${apartment.dailyPrice.toStringAsFixed(2)} / night",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${apartment.numberOfRooms} Rooms",
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
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          apartment.description,
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }

  Widget _bookNowButton(BuildContext context, Product apartment) {
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
                builder: (_) => BookingView(apartment: apartment),
              ),
            );
          },
          child: const Text(
            "Book Now",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _favoriteButton(WidgetRef ref) {
    return Positioned(
      top: 40,
      right: 20,
      child: CircleAvatar(
        backgroundColor: Colors.black45,
        child: IconButton(
          icon: Icon(
            ref.watch(favoritesProvider.notifier).isFavorite(apartment)
                ? Icons.favorite
                : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            final notifier = ref.read(favoritesProvider.notifier);
            if (notifier.isFavorite(apartment)) {
              notifier.remove(apartment);
            } else {
              notifier.add(apartment);
            }
          },
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
  }
}
