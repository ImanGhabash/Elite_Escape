import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/models/apartment_model.dart';

class FavoritesNotifier extends StateNotifier<List<Product>> {
  FavoritesNotifier() : super([]);

  void add(Product apartment) {
    if (!state.any((a) => a.id == apartment.id)) {
      state = [...state, apartment];
    }
  }

  void remove(Product apartment) {
    state = state.where((a) => a.id != apartment.id).toList();
  }

  bool isFavorite(Product apartment) {
    return state.any((a) => a.id == apartment.id);
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Product>>(
        (ref) => FavoritesNotifier());
