import 'package:flutter/material.dart';
import '../../../domain/Product.dart';

buildProduct(Product product) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white
          ),
          child: imageAndStar(product),
        ),
        buildPrice(product)
      ],
    ),
  );
}

Padding buildPrice(Product product) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          maxLines: 1,
        ),
        Text(
          product.details,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: Color(0xFF929292),
          ),
        ),
        const SizedBox(height: 6),
        Text('\$ ${product.price}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF00C569),
          )
        )
      ]
    )
  );
}

Stack imageAndStar(Product product) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          product.main_image,
          fit: BoxFit.fill,
          height: 200,
        ),
      ),
      Positioned(
        left: 120.0,
        top: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Colors.white
          ),
          child: const Padding(
            padding: EdgeInsets.all(2),
            child: Icon(Icons.star_border),
          )
        )
      )],
  );
}