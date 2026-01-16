import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/controllers/favorite_controller.dart';
import 'package:task/core/theme/gradient_scaffold.dart';
import 'package:task/generated/l10n.dart';
import 'package:task/view/Home/Widget/product_card.dart';

const Color darkTeal = Color(0xFF285260);
const Color mediumTeal = Color(0xFF5A9C92);
const Color lightAqua = Color(0xFFB4D7D8);
const Color tanBrown = Color(0xFFAA8872);

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return GradientScaffold(
      appBar: AppBar(
        title: Text(S.of(context).favorites),
        backgroundColor: darkTeal,
        elevation: 0,
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text(
                S.of(context).no_favorites_yet,
                style: const TextStyle(color: Colors.white70),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.78,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: favorites.length,
              itemBuilder: (_, i) => ProductCard(product: favorites[i]),
            ),
    );
  }
}
