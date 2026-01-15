import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/controllers/booking_list_controller.dart';
import 'package:task/models/booking_model.dart';
import 'package:task/services/booking_service.dart';
import 'package:dio/dio.dart';

final bookingControllerProvider =
    StateNotifierProvider<BookingController, AsyncValue<Booking?>>(
        (ref) => BookingController(ref.read(bookingServiceProvider as ProviderListenable<BookingService>)));

class BookingController extends StateNotifier<AsyncValue<Booking?>> {
  final BookingService _service;
  BookingController(this._service) : super(const AsyncValue.data(null));

  Future<void> createBooking({
    required int apartmentId,
    required DateTime startDate,
    required DateTime endDate,
    required double totalPrice,
  }) async {
    state = const AsyncValue.loading();
    try {
      final booking = await _service.createBooking(
        apartmentId: apartmentId,
        startDate: startDate,
        endDate: endDate,
        totalPrice: totalPrice,
      );
      state = AsyncValue.data(booking);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        state = AsyncValue.error(
          Exception('This apartment is already booked for the selected dates.'),
          StackTrace.current,
        );
      } else {
        state = AsyncValue.error(
          Exception(e.message ?? 'Something went wrong'),
          e.stackTrace,
        );
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

Future<void> updateBooking({
  required int bookingId,
  required DateTime startDate,
  required DateTime endDate,
}) async {
  state = const AsyncValue.loading();
  try {
    final booking = await _service.updateBooking(
      bookingId: bookingId,
      startDate: startDate,
      endDate: endDate,
    );
    state = AsyncValue.data(booking);
  } catch (e, st) {
    state = AsyncValue.error(e, st);
  }
}

  Future<void> cancelBooking(int bookingId) async {
    state = const AsyncValue.loading();
    try {
      final booking = await _service.cancelBooking(bookingId);
      state = AsyncValue.data(booking);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
