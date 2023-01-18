class Review {
  int id;
  String first_name;
  String last_name;
  String image;
  int rating;
  String message;

  Review({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.image,
    required this.rating,
    required this.message});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? '',
      first_name: json['first_name']?? '',
      last_name: json['last_name']?? '',
      image: json['image']?? '',
      rating: json['rating']?? '',
      message: json['message']?? '',
    );
  }
}