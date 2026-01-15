// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:task/models/profile_model.dart';
// import '../models/user_model.dart';
// import '../models/my_booking_model.dart';

// class UserProfileService {
//   final String baseUrl = 'http://127.0.0.1:8000/api';

//   Future<Map<String, dynamic>> fetchProfile(String token) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/user/show-profile'),
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final user = UserModel.fromJson(data['user']);
//       final bookings = (data['bookings'] as List)
//           .map((b) => MyBookingModel.fromJson(b))
//           .toList();

//       return {'user': user, 'bookings': bookings};
//     } else {
//       throw Exception('Failed to load profile');
//     }
//   }
// }
