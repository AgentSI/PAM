import 'package:flutter/cupertino.dart';

class Product {
  Color colour;
  String name;
  String main_image;
  double price;
  String details;
  String size;
  int id;

  Product({
    required this.colour,
    required this.name,
    required this.main_image,
    required this.price,
    required this.details,
    required this.size,
    required this.id
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    Color color = getColor(json['colour']);
    return Product(
      colour: color,
      name: json['name']?? '',
      main_image: json['main_image']?? '',
      price: json['price']?? '',
      details: json['details']?? '',
      size: json['size']?? '',
      id: json['id']?? '',
    );
  }

  static Color getColor(String color) {
    Color colorColor;
    if (color.toLowerCase() == 'white') {
      colorColor = const Color.fromRGBO(252, 252, 252, 100);
    } else if (color.toLowerCase() == 'blue') {
      colorColor = const Color.fromRGBO(19, 117, 173, 100);
    } else if (color.toLowerCase() == 'red') {
      colorColor = const Color.fromRGBO(222, 22, 22, 100);
    } else if (color.toLowerCase() == 'green') {
      colorColor = const Color.fromRGBO(49, 117, 53, 100);
    }else if (color.toLowerCase() == 'yellow') {
      colorColor = const Color.fromRGBO(226, 245, 54, 100);
    }else if (color.toLowerCase() == 'pink') {
      colorColor = const Color.fromRGBO(224, 141, 223, 100);
    }else {
      colorColor = const Color.fromRGBO(0, 0, 0, 100);
    }
    return colorColor;
  }
}