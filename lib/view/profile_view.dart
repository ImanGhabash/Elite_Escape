// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../controllers/profile_controller.dart';
// import '../models/user_model.dart';

// const Color darkTeal = Color(0xFF285260);
// const Color mediumTeal = Color(0xFF5A9C92);
// const Color lightAqua = Color(0xFFB4D7D8);
// const Color lightBeige = Color(0xFFE0CFBF);
// const Color tanBrown = Color(0xFFAA8872);

// class ProfileScreen extends ConsumerStatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends ConsumerState<ProfileScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       ref.read(profileControllerProvider.notifier).fetchProfile();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profileState = ref.watch(profileControllerProvider);

//     return profileState.when(
//       loading: () => const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       ),
//       error: (error, _) => Scaffold(
//         body: Center(child: Text(error.toString())),
//       ),
//       data: (user) => _ProfileContent(user: user),
//     );
//   }
// }

// class _ProfileContent extends StatelessWidget {
//   final User user;
//   const _ProfileContent({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [darkTeal, mediumTeal, lightAqua, tanBrown],
//                 stops: [0.0, 0.35, 0.65, 1.0],
//               ),
//             ),
//           ),
//           const Positioned(
//             top: 100,
//             left: 0,
//             right: 0,
//             child: Center(child: ProfileAvatar()),
//           ),
//           Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.only(top: 150),
//               child: ProfileCard(user: user),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ----------------------------
// // Avatar
// class ProfileAvatar extends StatelessWidget {
//   const ProfileAvatar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       height: 200,
//       decoration: BoxDecoration(
//         color: lightBeige,
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.white, width: 4),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: const Icon(Icons.person, size: 120, color: darkTeal),
//     );
//   }
// }

// // ----------------------------
// // Card
// class ProfileCard extends StatelessWidget {
//   final User user;
//   const ProfileCard({super.key, required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 25),
//       padding: const EdgeInsets.all(25),
//       constraints: const BoxConstraints(maxWidth: 400),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const SizedBox(width: 40),
//               Text(
//                 '${user.firstName} ${user.lastName}',
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: darkTeal,
//                 ),
//               ),
//               const Icon(Icons.apartment, color: mediumTeal),
//             ],
//           ),
//           const SizedBox(height: 15),
//           ContactInfoRow(
//             icon: Icons.phone,
//             text: user.mobileNumber,
//             color: darkTeal,
//             isVerified: true,
//           ),
//           const Divider(height: 30, color: lightAqua),
//         ],
//       ),
//     );
//   }
// }

// // ----------------------------
// // Contact Row
// class ContactInfoRow extends StatelessWidget {
//   final IconData icon;
//   final String text;
//   final Color color;
//   final bool isVerified;

//   const ContactInfoRow({
//     required this.icon,
//     required this.text,
//     required this.color,
//     this.isVerified = false,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, color: mediumTeal, size: 28),
//         const SizedBox(width: 15),
//         Expanded(
//           child: Text(
//             text,
//             style: TextStyle(fontSize: 18, color: color),
//           ),
//         ),
//         if (isVerified)
//           const Icon(Icons.check_circle, color: mediumTeal, size: 20),
//       ],
//     );
//   }
// }
