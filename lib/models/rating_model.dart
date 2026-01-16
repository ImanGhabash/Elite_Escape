class RatingModel {
  final int id;
  final int rating;
  final String comment;
  final String userName;

  RatingModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.userName,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'],
      rating: json['rating'],
      comment: json['comment'],
      userName:
          "${json['user']['first_name']} ${json['user']['last_name']}",
    );
  }
}
