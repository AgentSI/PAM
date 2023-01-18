import 'package:flutter/material.dart';
import '../../../domain/Category.dart';

buildCategory(Category category) {
  return Padding(
      padding: const EdgeInsets.all(2),
      child: GestureDetector(child: categoryCard(category)));
}

Column categoryCard(Category category) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(55),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7
              )]
        ),
        child: GridTile(
          child: Column(
            children: [imageCategory(category)]
          ),
        ),
    ),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 7),
    child: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: SizedBox(
        width: 60,
        child: Text('${category.name.substring(0, 10)}..',
          style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black),
        ),
      ))
    )]
  );
}

Container imageCategory(Category category) {
  return Container(
    height: 60,
    width: 60,
    padding: const EdgeInsets.all(15),
    child: Center(
      child: Image.network(
        category.icon,
        fit: BoxFit.cover,
      ),
    )
  );
}