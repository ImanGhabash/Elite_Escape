class BookingModel {
  DateTime startDate;
  DateTime endDate;
  int numberOfGuests;
  int totalPrice;
  int days;

  BookingModel({
    required this.startDate,
    required this.endDate,
    required this.numberOfGuests,
    required this.totalPrice,
    required this.days,
  });
}
