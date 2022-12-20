import 'package:flutter/material.dart';
import 'package:shop/main.dart';

GridView products(data) {
  Shop items = data.data;
  return GridView.builder(
    physics: const ScrollPhysics(),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 1 / 1.5
    ),
    itemCount: items.products!.length,
    itemBuilder: (context, index) {
      return Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Container(
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3.0),
                        child: Image.network(
                          items.products![index].cover.toString())),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(7),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              height: 30,
                              width: 30,
                              child: const Center(
                                child: Icon(
                                  Icons.star_border_rounded, size: 16)
                              )
                            )]
                        )
                      )]
                  ),
                  const SizedBox(height: 8),
                  Text(items.products![index].title.toString(),
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                  Text(items.products![index].subtitle.toString(),
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text("${items.products![index].price} ${items.products![index].currency}",
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 197, 105, 1)))]
              )]
          )
        )
      );
    }
  );
}