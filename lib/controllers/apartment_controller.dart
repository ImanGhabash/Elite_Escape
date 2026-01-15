import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/models/apartment_model.dart';
import 'package:task/services/apartment_service.dart';
// import 'package:task/services/product_service.dart';

class ProductController
    extends StateNotifier<AsyncValue<List<Product>>> {

  ProductController() : super(const AsyncLoading()) {
    fetchProducts();
  }

  final ProductService _service = ProductService();

  List<Product> _allProducts = [];

  Future<void> fetchProducts() async {
    try {
      final products = await _service.fetchProducts(); // 👈 هون التعديل المهم
      _allProducts = products;
      state = AsyncData(products);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void applyLocalFilter(Map<String, dynamic> filters) {
    final filtered = _allProducts.where((p) {
final price = double.tryParse(p.dailyPrice?.toString() ?? '0') ?? 0;

      if (filters['governorate'] != null &&
          p.governorate != filters['governorate']) {
        return false;
      }

      if (filters['city'] != null &&
          p.city != filters['city']) {
        return false;
      }

      if (filters['rooms'] != null &&
          p.numberOfRooms != filters['rooms']) {
        return false;
      }

      if (filters['minPrice'] != null &&
          price < filters['minPrice']) {
        return false;
      }

      if (filters['maxPrice'] != null &&
          price > filters['maxPrice']) {
        return false;
      }

      return true;
    }).toList();

    state = AsyncData(filtered);
  }

  void resetFilter() {
    state = AsyncData(_allProducts);
  }
}
final productControllerProvider =
    StateNotifierProvider<ProductController, AsyncValue<List<Product>>>(
  (ref) => ProductController(),
);
