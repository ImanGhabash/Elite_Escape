import 'package:dio/dio.dart';
import 'package:task/models/booking_model.dart';
import 'dio_service.dart';


class BookingService {
  final Dio dio;
  BookingService(this.dio);

  Future<Booking> createBooking({
    required int apartmentId,
    required DateTime startDate,
    required DateTime endDate,
    required double totalPrice,
  }) async {
    final response = await dio.post(
      '/user/apartments/book'
      ,
      data: {
        'apartment_id': apartmentId,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
        'total_price': totalPrice.toString(),

      },
    );
    return Booking.fromJson(response.data['booking']);
  }

Future<Booking> updateBooking({
  required int bookingId,
  required DateTime startDate,
  required DateTime endDate,
}) async {
  final response = await dio.post(
    '/user/updatebookings/$bookingId',
    data: {
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
    },
  );

  return Booking.fromJson(response.data['data']);
}



  Future<Booking> cancelBooking(int bookingId) async {
    final response = await dio.post('/user/bookings/cancel/$bookingId');
    final bookingJson = response.data['booking'];
    return Booking.fromJson(bookingJson);
  }

Future<List<Booking>> fetchBookings() async {
    print(DioService().dio.options.headers);
  final response = await dio.get('/user/my-bookings');
  final bookingsJson = response.data['bookings'] as List;
  return bookingsJson.map((json) => Booking.fromJson(json)).toList();
}

}
