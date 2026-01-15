// class Product {
//   final String id;
//   final String title;
//   final String image;
//   final String type; // Apartment, Villa, ...
//   final String description;
//   final double price;

//   Product({
//     required this.id,
//     required this.title,
//     required this.image,
//     required this.type,
//     required this.description,
//     required this.price,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'].toString(),
//       title: json['title'],
//       image: json['image'],
//       type: json['type'],
//       description: json['description'],
//       price: double.parse(json['price'].toString()),
//     );
//   }
// }
