import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task/models/booking_model.dart';
// import 'package:task/view/booking.dart';
// import 'package:intl/intl.dart';

import '../main.dart';

class CartScreen extends StatefulWidget {
  final BookingModel? booking;

  CartScreen({this.booking});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  BookingModel? currentBooking;

  @override
  void initState() {
    super.initState();
    currentBooking = widget.booking;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bookings"),
        backgroundColor: Color(0xff285260),
      ),
      body: currentBooking == null
          ? Center(child: Text("No bookings yet"))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.hotel, color: Color(0xff285260), size: 40),
                  title: Text("Luxury Apartment", style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("${currentBooking!.days} Nights | ${currentBooking!.numberOfGuests} Guests"),
                ),
                Divider(),
                _infoRow("Check-in", DateFormat("dd MMM").format(currentBooking!.startDate)),
                _infoRow("Check-out", DateFormat("dd MMM").format(currentBooking!.endDate)),
                _infoRow("Total Price", "\$${currentBooking!.totalPrice}", isBold: true),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.edit, size: 18),
                        label: Text("Edit"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() => currentBooking = null);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Booking Cancelled")));
                        },
                        icon: Icon(Icons.delete_outline, size: 18),
                        label: Text("Cancel"),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red[400]),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
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
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: isBold ? 18 : 14)),
        ],
      ),
    );
  }
}