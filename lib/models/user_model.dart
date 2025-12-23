class User {
  final int id;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String role;
  final String dateOfBirth;
  final bool isApproved;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.role,
    required this.dateOfBirth,
    required this.isApproved,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      mobileNumber: json['mobile_number'],
      role: json['role'],
      dateOfBirth: json['date_of_birth'],
      isApproved: json['is_approved'] == 1,
    );
  }
}