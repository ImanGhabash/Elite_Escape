class Owner {
  final int id;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String personalPhoto;

  Owner({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.personalPhoto,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      personalPhoto: json['personal_photo'] ?? '',
    );
  }
}




class Product {
  final int id;
  final String title;
  final String description;
  final String city;
  final String governorate;
  final String address;
  final double dailyPrice;
  final int numberOfRooms;
  final bool isAvailable;
  final Owner owner;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.city,
    required this.governorate,
    required this.address,
    required this.dailyPrice,
    required this.numberOfRooms,
    required this.isAvailable,
    required this.owner,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
  final images = json['images'] as List<dynamic>?;

  return Product(
    id: json['id'] ?? 0,
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    city: json['city'] ?? '',
    governorate: json['governorate'] ?? '',
    address: json['address'] ?? '',
    dailyPrice: double.tryParse(json['daily_price'].toString()) ?? 0.0,
    numberOfRooms: json['number_of_rooms'] ?? 0,
    isAvailable: (json['is_available'] ?? 1) == 1,
    owner: Owner.fromJson(json['owner'] ?? {}),
    imageUrl: images != null && images.isNotEmpty
        ? images.first['image_path'] ?? ''
        : '',
  );
}

}