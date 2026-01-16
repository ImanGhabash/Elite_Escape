import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/models/apartment_model.dart';

class FavoritesNotifier extends StateNotifier<List<Product>> {
  FavoritesNotifier() : super([]);

  void toggle(Product product) {
    final exists = state.any((p) => p.id == product.id);

    if (exists) {
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product];
    }
  }

  bool isFavorite(Product product) {
    return state.any((p) => p.id == product.id);
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Product>>(
  (ref) => FavoritesNotifier(),
);
