import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../domain/Product.dart';
import '../domain/ProductReview.dart';

class ProductController extends GetxController {
  String url = "http://mobile-shop-api.hiring.devebs.net/products";
  int totalCount = 0;
  List<Product> productList = [];

  Future<List<Product>> getProducts(int page) async {
    final response = await http.get(Uri.parse("$url?page=$page"));
    List<Product> products = [];
    if (response.statusCode == 200) {
      totalCount = json.decode(response.body)["count"];
      dynamic productsJson = json.decode(response.body)["results"];
      productsJson.forEach((object){
        products.add(Product.fromJson(object));
      });
    }
    return products;
  }

  Future<ProductReview> getProduct(int id) async {
    final response = await http.get(Uri.parse("$url/$id"));
    ProductReview? product;
    if (response.statusCode == 200) {
      dynamic productJson = json.decode(response.body);
      product = ProductReview.fromJson(productJson);
    }
    if (product != null) {
      return product;
    } else {
      throw("error");
    }
  }
}