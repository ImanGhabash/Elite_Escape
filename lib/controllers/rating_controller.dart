import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:task/services/review_service.dart';
import 'package:task/models/rating_model.dart';
import 'package:task/services/rating_service.dart';

final reviewServiceProvider =
    Provider((ref) => ReviewService());

final reviewsProvider =
    FutureProvider.family<List<RatingModel>, int>((ref, apartmentId) async {
  final service = ref.read(reviewServiceProvider);
  final data = await service.getReviews(apartmentId);
  return data.map((e) => RatingModel.fromJson(e)).toList();
});
