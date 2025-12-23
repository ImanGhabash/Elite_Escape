import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task/models/booking_model.dart';
// ignore: depend_on_referenced_packages
// import 'package:intl/intl.dart';

import '../main.dart';
import 'cart_screen.dart';


class Booking extends StatefulWidget {
  //final String apartmentName;

//  const Booking({super.key, required this.apartmentName});
  @override
  State<Booking> createState() => _BookingState();
}
int pricePerNight = 500;
int totalAmount = 0;
int numberOfGuests = 1;
const Color darkTeal = Color(0xff285260);
const Color mediumTeal = Color(0xff5A9C92);
const Color lightAqua = Color(0xffB4D7D8);
const Color tanBrown = Color(0xffAA8872);

class _BookingState extends State<Booking> {
  TextEditingController guestcontroller = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  int daysDifference = 0;


  Future<void> _selectStartDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        startDate = picked;

        if (endDate != null && endDate!.isBefore(startDate!)) {
          endDate = null;
        }
        _calculateDifference();
      });
    }
  }


  Future<void> _selectEndDate(BuildContext context) async {

    if (startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يرجى اختيار تاريخ الوصول أولاً"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }
    DateTime initialDateForEnd = endDate ?? startDate!.add(const Duration(days: 1));

    if (initialDateForEnd.isBefore(startDate!)) {
      initialDateForEnd = startDate!.add(const Duration(days: 1));
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDateForEnd,
      firstDate: startDate!.add(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
        _calculateDifference();
      });
    }
  }
  void _calculateDifference() {
    if (startDate != null && endDate != null) {
      setState(() {
        daysDifference = endDate!.difference(startDate!).inDays;
        if (daysDifference <= 0) daysDifference = 1;
        totalAmount = daysDifference * pricePerNight;
      });
    }
  }


  String _formatDate(DateTime? date) {
    if (date == null) return "select date";
    return DateFormat("dd, MMM yyyy").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [darkTeal, mediumTeal, lightAqua, tanBrown],
            stops: [0.0, 0.37, 0.60, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 30),
                ),
              ),
              SizedBox(height: 30),
              Text(
                  "Complete Your Booking.....",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  )
              ),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  child: Image.asset(
                    "images/3a5be22e09f1749553065fcb79dbf69b.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Select Date :", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),


              datePickerTile("Check-in Date", _formatDate(startDate), () => _selectStartDate(context)),
              SizedBox(height: 15),


              datePickerTile("Check-out Date", _formatDate(endDate), () => _selectEndDate(context)),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Number of Guests",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                    Row(
                      children: [
                        _buildCounterButton(Icons.remove, () {
                          if (numberOfGuests > 1) setState(() => numberOfGuests--);
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text("$numberOfGuests",
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        _buildCounterButton(Icons.add, () {
                          setState(() => numberOfGuests++);
                        }),
                      ],
                    ),
                  ],
                ),
              ),


              if (daysDifference > 0)
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      _priceRow("Price per night", "\$$pricePerNight"),
                      _priceRow("Duration", "$daysDifference Nights"),
                      Divider(height: 30, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Amount", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("\$$totalAmount",
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: darkTeal)),
                        ],
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 120),

              ElevatedButton(
                onPressed: () {
                  if (startDate != null && endDate != null) {

                    final newBooking = BookingModel(
                      //apartmentName: widget.apartmentName,
                      startDate: startDate!,
                      endDate: endDate!,
                      numberOfGuests: numberOfGuests,
                      totalPrice: totalAmount,
                      days: daysDifference,
                    );


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(booking: newBooking),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("يرجى اختيار التواريخ أولاً")),
                    );
                  }
                },style: ElevatedButton.styleFrom(

                backgroundColor: Colors.green,

                minimumSize: Size(double.infinity, 55),

                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

              ),

                child: Text("Book Now", style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }}


  Widget datePickerTile(String title, String dateText, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        width: double.infinity,
        child: Column(
          children: [
            Text(title, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_month, color: Colors.black),
                SizedBox(width: 10),
                Text(dateText, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

Widget _buildCounterButton(IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: darkTeal, size: 20),
    ),
  );
}

Widget _priceRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 15)),
        Text(
            value, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
      ],
    ),
  );
}

