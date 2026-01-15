// class MyBookingModel {
//   final int id;
//   final int apartmentId;
//   final String status;

//   MyBookingModel({
//     required this.id,
//     required this.apartmentId,
//     required this.status,
//   });

//   factory MyBookingModel.fromJson(Map<String, dynamic> json) {
//     return MyBookingModel(
//       id: json['id'],
//       apartmentId: json['apartment_id'],
//       status: json['status'] ?? '',
//     );
//   }
// }