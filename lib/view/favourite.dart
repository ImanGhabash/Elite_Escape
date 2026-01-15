import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/controllers/favorite_controller.dart';
import 'package:task/view/Home/Widget/product_card.dart';
import 'package:task/view/property_deatils_view.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final apartment = favorites[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: ImageUtils.fixImageUrl(apartment.imageUrl),
                    width: 50,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.broken_image),
                  ),

                  title: Text(apartment.title),
                  // subtitle: Text("\$${apartment.price}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PropertyDetailsScreen(apartment: apartment),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
