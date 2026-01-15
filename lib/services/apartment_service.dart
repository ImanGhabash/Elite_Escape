// services/product_service.dart
import 'package:dio/dio.dart';
import 'package:task/models/apartment_model.dart';
// import '../models/product.dart';

class ProductService {
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts() async {
    
final response = await _dio.get(
  'http://10.0.2.2:8000/api/apartments',
);

    if (response.statusCode == 200) {
      final List jsonData = response.data;
      return jsonData.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
