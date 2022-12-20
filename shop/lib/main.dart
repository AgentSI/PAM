import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/home_page.dart';

void main() => runApp(const MyApp());

Future readJsonData() async {
  final jsonData = await rootBundle.loadString('assets/shop.json');
  final list = json.decode(jsonData);
  return Shop.fromJson(list);
}

class Shop {
  List<Categories>? categories;
  List<Products>? products;

  Shop({this.categories, this.products});

  factory Shop.fromJson(Map<String, dynamic> json) {
    var list1 = json['categories'] as List;
    List<Categories> listCategories = list1.map((e) => Categories.fromJson(e)).toList();

    var list2 = json['products'] as List;
    List<Products> listProducts = list2.map((e) => Products.fromJson(e)).toList();

    return Shop(
      categories: listCategories,
      products: listProducts,
    );
  }
}

class Categories {
  String? title;
  String? icon;

  Categories({
    this.title,
    this.icon,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      title: json['title'],
      icon: json['icon'],
    );
  }
}

class Products {
  String? cover;
  String? title;
  String? subtitle;
  int? price;
  String? currency;

  Products({
    this.cover,
    this.title,
    this.subtitle,
    this.price,
    this.currency,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      cover: json['cover'],
      title: json['title'],
      subtitle: json['sub_title'],
      price: json['price'],
      currency: json['currency'],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false
    );
  }
}