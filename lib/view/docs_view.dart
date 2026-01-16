// import 'package:flutter/material.dart';
// import 'package:task/data/doc_data.dart';
// import 'package:task/widgets/docs_card.dart';
//  class DocsView extends StatelessWidget {
//   const DocsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     appBar: AppBar(
//       title: Text("My Docements"),
//     ),
//       body:
//         Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   darkTeal,
//                   mediumTeal,
//                   lightAqua,
//                   // lightBeige,
//                   tanBrown,
//                 ],
//                 stops: [0.0, 0.35, 0.65, 1.0],
//               ),
//             ),
          

//         child: ListView.builder(
//           padding: EdgeInsets.all(12),
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             final p = docs[index];
         
//             return DocsCard(
//               name: p["name"],
//               image: p["image"],
//               onTap: () {
                
//               },
//             );
//           },
//         ),
//       ),
    
//     );
//   }
// }