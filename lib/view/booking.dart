import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task/controllers/booking_controller.dart';
import 'package:task/controllers/booking_list_controller.dart';
import 'package:task/models/apartment_model.dart';
import 'package:task/models/booking_model.dart';
import 'package:task/view/cart_screen.dart';



const Color darkTeal = Color(0xFF285260);
const Color mediumTeal = Color(0xFF5A9C92);
const Color lightAqua = Color(0xFFB4D7D8);
const Color tanBrown = Color(0xFFAA8872);

class BookingView extends ConsumerStatefulWidget {
  final Product apartment;
  final Booking? existingBooking;

  const BookingView({
    super.key,
    required this.apartment,
    this.existingBooking,
  });

  @override
  ConsumerState<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends ConsumerState<BookingView> {
  DateTime? startDate;
  DateTime? endDate;

  late int pricePerNight;
  int totalDays = 0;
  int totalAmount = 0;

  @override
  void initState() {
    super.initState();
    pricePerNight = widget.apartment.dailyPrice.toInt();

    if (widget.existingBooking != null) {
      startDate = widget.existingBooking!.startDate;
      endDate = widget.existingBooking!.endDate;
      calculateTotal();
      _background();
    }
  }
  Widget _background() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [darkTeal, mediumTeal, lightAqua, tanBrown],
        ),
      ),
    );
  }

  void calculateTotal() {
    if (startDate != null && endDate != null) {
      totalDays = endDate!.difference(startDate!).inDays;
      if (totalDays < 1) totalDays = 1;
      totalAmount = totalDays * pricePerNight;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<Booking?>>(
      bookingControllerProvider,
      (previous, next) {
        next.whenOrNull(
          data: (booking) async {
            if (booking != null) {
              await ref.read(bookingListProvider.notifier).refresh();
              if (!mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            }
          },
          error: (e, _) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Booking Error'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    final bookingState = ref.watch(bookingControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Booking")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.apartment.title ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            /// Start Date
            ListTile(
              title: Text(
                startDate == null
                    ? "Select start date"
                    : DateFormat("yyyy-MM-dd").format(startDate!),
              ),
              trailing: const Icon(Icons.calendar_month),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  initialDate: startDate ?? DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    startDate = picked;
                    calculateTotal();
                  });
                }
              },
            ),

            /// End Date
            ListTile(
              title: Text(
                endDate == null
                    ? "Select end date"
                    : DateFormat("yyyy-MM-dd").format(endDate!),
              ),
              trailing: const Icon(Icons.calendar_month),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  firstDate: startDate ?? DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  initialDate: endDate ?? DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    endDate = picked;
                    calculateTotal();
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            /// Price Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Price per night: \$${pricePerNight}"),
                  const SizedBox(height: 8),
                  Text("Days: $totalDays"),
                  const SizedBox(height: 8),
                  Text(
                    "Total: \$${totalAmount}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// Book / Update Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: bookingState.isLoading
                    ? null
                    : () {
                        if (startDate == null || endDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please select dates first"),
                            ),
                          );
                          return;
                        }

                        final controller =
                            ref.read(bookingControllerProvider.notifier);

   if (widget.existingBooking != null) {
  controller.updateBooking(
    bookingId: widget.existingBooking!.id,
    startDate: startDate!,
    endDate: endDate!,
  );
} else {
  controller.createBooking(
    apartmentId: widget.apartment.id,
    startDate: startDate!,
    endDate: endDate!,
    totalPrice: totalAmount.toDouble(),
  );
}

                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor:darkTeal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: bookingState.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        widget.existingBooking != null
                            ? "Update Booking"
                            : "Book Now",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
