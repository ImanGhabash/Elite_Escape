import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task/controllers/booking_controller.dart';
import 'package:task/controllers/booking_list_controller.dart';
import 'package:task/models/booking_model.dart';
import 'package:task/view/booking.dart';
// import 'package:task/services/booking_service.dart' as bookingService;

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsState = ref.watch(bookingListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
        backgroundColor: const Color(0xff285260),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (route) => false,
          ),
        ),
      ),
      body: bookingsState.when(
        data: (bookings) => bookings.isEmpty
            ? const Center(child: Text("No bookings yet"))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.hotel,
                                color: const Color(0xff285260), size: 40),
                            title: Text(
                              booking.product.title,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (booking.status == "cancelled")
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                "Cancelled",
                                style: TextStyle(
                                    color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                            ),
                          const Divider(),
                          _infoRow(
                              "Check-in",
                              DateFormat("dd MMM").format(booking.startDate)),
                          _infoRow(
                              "Check-out",
                              DateFormat("dd MMM").format(booking.endDate)),
                          _infoRow("Total Price", "\$${booking.totalPrice}",
                              isBold: true),
                          const SizedBox(height: 10),

                          // أزرار تعديل وإلغاء
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // زر التعديل
                              TextButton.icon(
                                onPressed: booking.status == "cancelled"
                                    ? null
                                    : () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => BookingView(
                                              apartment: booking.product,
                                              existingBooking: booking,
                                            ),
                                          ),
                                        );
                                      },
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                label: const Text("Edit",
                                    style: TextStyle(color: Colors.blue)),
                              ),
                              const SizedBox(width: 10),

                              // زر الإلغاء
                              TextButton.icon(
                                onPressed: booking.status == "cancelled"
                                    ? null
                                    : () async {
                                        final confirm = await showDialog<bool>(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: const Text("Cancel Booking"),
                                            content: const Text(
                                                "Are you sure you want to cancel this booking?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context, false),
                                                  child: const Text("No")),
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context, true),
                                                  child: const Text("Yes")),
                                            ],
                                          ),
                                        );

                                        if (confirm ?? false) {
                                          try {
   await ref
    .read(bookingControllerProvider.notifier)
    .cancelBooking(booking.id);

await ref.read(bookingListProvider.notifier).refresh();


                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                    content: Text("Booking cancelled")));
                                          } catch (e) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text("Failed to cancel: $e")));
                                          }
                                        }
                                      },
                                icon: const Icon(Icons.cancel, color: Colors.red),
                                label: const Text("Cancel", style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text("Error: $e")),
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: isBold ? 18 : 14)),
        ],
      ),
    );
  }
}
