// import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/models/booking_model.dart';
import 'package:task/services/booking_service.dart';
import 'package:task/services/dio_service.dart';


final bookingServiceProvider = Provider<BookingService>(
  (ref) => BookingService(DioService().dio),
);


final bookingListProvider =
    StateNotifierProvider<BookingListController, AsyncValue<List<Booking>>>(
  (ref) => BookingListController(ref),
);




class BookingListController extends StateNotifier<AsyncValue<List<Booking>>> {
  final Ref ref; // بدل Reader

  BookingListController(this.ref) : super(const AsyncValue.loading()) {
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    state = const AsyncValue.loading();
    try {
      final bookings = await ref.read(bookingServiceProvider).fetchBookings();
      state = AsyncValue.data(bookings);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
    Future<void> refresh() async {
    await fetchBookings();
  }
}
