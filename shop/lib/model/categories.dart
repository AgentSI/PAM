import 'package:flutter/material.dart';
import 'package:shop/main.dart';

ListView categories(data) {
  Shop items = data.data;
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemCount: items.categories!.length,
    itemBuilder: (context, index) {
      return Column(
        children: [
          Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(20, 0, 0, 0),
                    blurRadius: 10,
                    offset: Offset(0, 6))]
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Image.network(items.categories![index].icon.toString(), fit: BoxFit.scaleDown)
              )
          ),
          const SizedBox(height: 14),
          Text(items.categories![index].title.toString(), style: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 12, fontFamily: 'SF Pro Text')
          )]
      );
    },
  );
}