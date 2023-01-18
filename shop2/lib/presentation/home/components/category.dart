import 'package:flutter/material.dart';
import 'build_category.dart';

ListView category(categoryList) {
  return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: categoryList.length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: buildCategory(categoryList[index]),
        );
      });
}


