// // view/booking_list_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:task/view/profile_view.dart';
// // import '../controllers/profile_provider.dart';
// import '../models/my_booking_model.dart';

// const Color darkTeal = Color(0xFF285260);
// const Color mediumTeal = Color(0xFF5A9C92);
// const Color lightAqua = Color(0xFFB4D7D8);
// const Color tanBrown = Color(0xFFAA8872);

// class BookingListScreen extends ConsumerWidget {
//   final String token;
//   const BookingListScreen({super.key, required this.token});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final controller = ref.watch(profileProvider(token));

//     if (controller.isLoading) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (controller.hasError) {
//       return const Scaffold(
//         body: Center(child: Text('Error loading bookings')),
//       );
//     }

//     final bookings = controller.bookings;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Bookings'),
//         backgroundColor: darkTeal,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           MyBookingModel booking = bookings[index] as MyBookingModel;
//           return Card(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//             margin: const EdgeInsets.symmetric(vertical: 8),
//             child: ListTile(
//               leading: Icon(Icons.apartment, color: mediumTeal),
//               title: Text('Apartment ID: ${booking.apartmentId}'),
//               subtitle: Text('Status: ${booking.status}'),
//               trailing: Text('#${booking.id}'),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
