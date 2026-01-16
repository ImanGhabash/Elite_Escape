// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/user_model.dart';
// import '../services/auth_service.dart';
// import '../models/token_storage.dart';
// import '../services/dio_service.dart';

// final profileControllerProvider =
//     StateNotifierProvider<ProfileController, AsyncValue<User>>(
//   (ref) => ProfileController(),
// );

// class ProfileController extends StateNotifier<AsyncValue<User>> {
//   ProfileController() : super(const AsyncLoading());

//   final AuthService _authService = AuthService();

//   Future<void> fetchProfile() async {
//     try {
//       state = const AsyncLoading();


//       final token = await TokenStorage().getToken();
//       if (token == null) {
//         throw Exception('Not logged in');
//       }

//       DioService().setToken(token);

//       final user = await _authService.getProfile();
//       state = AsyncData(user);
//     } catch (e, stack) {
//       state = AsyncError(e, stack);
//     }
//   }
// }
