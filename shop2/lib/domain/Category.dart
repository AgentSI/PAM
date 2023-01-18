class Category {
  String name;
  String icon;

  Category({required this.name, required this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}