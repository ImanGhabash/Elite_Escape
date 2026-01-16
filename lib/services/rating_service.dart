import 'package:dio/dio.dart';
import 'package:task/services/dio_service.dart';

class ReviewService {
  final Dio _dio = DioService().dio; 

  Future<void> addReview({
    required int apartmentId,
    required int rating,
    required String comment,
  }) async {
    try {
      await _dio.post(
        'user/apartments/review/$apartmentId',
        data: {
          'rating': rating,
          'comment': comment,
        },
      );
    } catch (e) {
      print('Error sending review: $e');
      rethrow;
    }
  }

  Future<List<dynamic>> getReviews(int apartmentId) async {
    try {
      final response = await _dio.get('apartments/reviews/$apartmentId');
      return response.data['data'];
    } catch (e) {
      print('Error fetching reviews: $e');
      return [];
    }
  }
}