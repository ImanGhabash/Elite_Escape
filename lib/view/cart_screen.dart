import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task/controllers/booking_controller.dart';
import 'package:task/controllers/booking_list_controller.dart';
import 'package:task/core/theme/gradient_scaffold.dart';
import 'package:task/generated/l10n.dart';

import 'package:task/view/booking.dart';

const Color darkTeal = Color(0xFF285260);
const Color mediumTeal = Color(0xFF5A9C92);
const Color lightAqua = Color(0xFFB4D7D8);
const Color tanBrown = Color(0xFFAA8872);

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsState = ref.watch(bookingListProvider);

    return GradientScaffold(
      appBar: AppBar(
        title: Text(S.of(context).my_bookings),
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
            ? Center(child: Text(S.of(context).no_bookings_yet))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.hotel,
                              color: const Color(0xff285260),
                              size: 40,
                            ),
                            title: Text(
                              booking.product.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (booking.status == "cancelled")
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                S.of(context).cancelled,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          const Divider(),
                          _infoRow(
                            S.of(context).check_in,
                            DateFormat("dd MMM").format(booking.startDate),
                          ),
                          _infoRow(
                            S.of(context).check_out,
                            DateFormat("dd MMM").format(booking.endDate),
                          ),
                          _infoRow(
                            S.of(context).total,
                            "\$${booking.totalPrice}",
                            isBold: true,
                          ),
                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
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
                                icon: const Icon(Icons.edit, color: tanBrown),
                                label: Text(
                                  S.of(context).edit,
                                  style: TextStyle(color: tanBrown),
                                ),
                              ),
                              const SizedBox(width: 10),

                              TextButton.icon(
                                onPressed: booking.status == "cancelled"
                                    ? null
                                    : () async {
                                        final confirm = await showDialog<bool>(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: Text(
                                              S.of(context).cancel_booking,
                                            ),
                                            content: Text(
                                              S
                                                  .of(context)
                                                  .confirm_cancel_booking,
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                  context,
                                                  false,
                                                ),
                                                child: Text(S.of(context).no),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                  context,
                                                  true,
                                                ),
                                                child: Text(S.of(context).yes),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (confirm ?? false) {
                                          try {
                                            await ref
                                                .read(
                                                  bookingControllerProvider
                                                      .notifier,
                                                )
                                                .cancelBooking(booking.id);

                                            await ref
                                                .read(
                                                  bookingListProvider.notifier,
                                                )
                                                .refresh();

                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  S
                                                      .of(context)
                                                      .booking_cancelled,
                                                ),
                                              ),
                                            );
                                          } catch (e) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  S
                                                      .of(context)
                                                      .failed_to_cancel,
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                                label: Text(
                                  S.of(context).cancel,
                                  style: TextStyle(color: Colors.red),
                                ),
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
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
