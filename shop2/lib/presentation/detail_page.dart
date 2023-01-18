// ignore_for_file: unnecessary_null_comparison, import_of_legacy_library_into_null_safe, no_logic_in_create_state, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../domain/ProductReview.dart';
import '../domain/Review.dart';
import '../data/productController.dart';
import 'package:flutter/cupertino.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({required this.index});
  int index;

  @override
  State<ProductDetail> createState() => _ProductDetailState(index: index);
}

class _ProductDetailState extends State<ProductDetail> {
  _ProductDetailState({required this.index});
  int index;
  ProductReview? product;

  @override
  initState() {
    super.initState();
    final ProductController productController = Get.put(ProductController());
    productController.getProduct(index).then((value) => {
      setState(() {
        product = value;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: 1,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: Text("...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                decoration: TextDecoration.none
              ),
            ),
          )
        ),
      );
    } else {
      return Scaffold(
        appBar: detailAppBar(product!),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    product!.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: sizeAndColor(product!),
              ),
              Padding(padding: const EdgeInsets.all(15),
                  child: detailsSection(product!)),
              Padding(padding: const EdgeInsets.only(left: 15, right: 15),
              child: _staticText('Review', Colors.black, FontWeight.bold, 20)),
              const SizedBox(height: 15),
              Padding(padding: const EdgeInsets.only(left: 15, right: 15),
              child: _staticText('Write your', const Color(0xFF00C569), FontWeight.normal, 15)),
              const SizedBox(height: 15),
              reviewList(product!.reviews),
            ]
          )
        ),
        bottomNavigationBar: bottomBar(product!),
      );
    }
  }

  BottomAppBar bottomBar(ProductReview product) {
    return BottomAppBar(
      color: Colors.white,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.primary),
        child: Row(
          children: [
            SizedBox(height: 60,child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Text('PRICE',
              style: TextStyle(
                color: Color(0xFF929292)
              ),),
              Padding(padding: const EdgeInsets.only(top: 3),
                child: Text('\$ ${product.price}',
                  style: const TextStyle(
                      color: Color(0xFF00C569),
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  )))
              ]
            )
            )),
            const Spacer(),
            SizedBox(height: 60,child: Padding(
              padding: const EdgeInsets.only(right: 25, top: 10, bottom: 10),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: const Color(0xFF00C569),
                  ),
                alignment: Alignment.center,
                width: 150,
                child: const Padding(padding: EdgeInsets.all(10),
                child: Text('ADD',
                  style: TextStyle(color: Colors.white),
                ))
              ),
            ),)
          ],
        ),
      ),
    );
  }

  Column detailsSection(ProductReview productReview) {
    return Column(
      children: [
        _staticText('Details', Colors.black, FontWeight.bold, 20),
        const SizedBox(height: 15),
        Text(
          product!.details,
          textAlign: TextAlign.left,
          maxLines: 3,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15
          ),
        ),
        const SizedBox(height: 15),
        _staticText('Read More', const Color(0xFF00C569), FontWeight.normal, 15),
      ],
    );
  }

  Expanded reviewList(List<Review> reviews) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: reviews.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: _test(reviews[index])
            )
          );
        },
      ),
    );
  }

  Stack _test(Review review) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(55),
          child: const Icon(Icons.person),
        ),
        Positioned(left: 70,
          width: 300,
          height: 20,child:
          Row(
            children: [
              Text(review.first_name + review.last_name),
              const Spacer()]
          ),
        ),
        Positioned(left: 70, top: 30, child: Text(review.message, textAlign: TextAlign.left))],
    );
  }

  Row _staticText(String text, Color color, FontWeight fontWeight, double size) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
              fontWeight: fontWeight,
              fontSize: size,
              color: color
          ),
        ),
        const Spacer()
      ],
    );
  }

  Row sizeAndColor(ProductReview product) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 1,child: detailSize(product.size),),
        Expanded(flex: 1,child: detailColor(product.colour),),
      ],
    );
  }

  Padding detail(Padding row) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(55),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10
                )
              ]
          ),
          child: GridTile(child: row),
        )
    );
  }
  
  Padding detailSize(String size) {
    Row row = Row(
      children: [
        const Text('Size',
        style: TextStyle(fontSize: 18)),
        const Spacer(),
        Text((size.length > 14) ? 'Universal' : size)
      ],
    );
    Padding padding = Padding(padding: const EdgeInsets.all(15),
    child: row);
    return detail(padding);
  }

  Padding detailColor(Color color) {
    Row row = Row(
      children: [
        const Text('Color',
            style: TextStyle(fontSize: 18)),
        const Spacer(),
        Icon(Icons.circle, color: color)
      ],
    );
    Padding padding = Padding(padding: const EdgeInsets.all(15), child: row);
    return detail(padding);
  }

  AppBar detailAppBar(ProductReview product) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 150,
      backgroundColor: Colors.white,
      flexibleSpace: Image.network(product.main_image, fit: BoxFit.cover),
      leading: closeActivity(),
      actions: const [
        Padding(
          padding: EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.star_border,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  GestureDetector closeActivity() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            CupertinoIcons.arrow_left,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
