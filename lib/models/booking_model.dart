import 'package:task/models/apartment_model.dart';

// مودل Booking مع ربطه بالشقة
class Booking {
  final int id;
  final int userId;
  final DateTime startDate;
  final DateTime endDate;
  final double totalPrice;
  final String status;
  final String? paymentDetails;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product; // الرابط مع الشقة

  Booking({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.status,
    this.paymentDetails,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['user_id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      totalPrice: double.parse(json['total_price'].toString()),
      status: json['status'] ?? 'pending',
      paymentDetails: json['payment_details'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      product: Product.fromJson(json['apartment'] ?? {}), // لو null خلي object فارغ
    );
  }
}
