import 'package:flutter/material.dart';
import 'package:shop/model/categories.dart';
import 'package:shop/model/products.dart';
import 'main.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: readJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              return ListView(
                children: [
                  const SizedBox(
                    height: 24,
                    width: 99,
                    child: Text(" Categories", textAlign: TextAlign.left, style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 18, fontFamily: 'SF Pro Text')),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 90,
                    child: categories(data)),
                  const SizedBox(height: 44),
                  Row(
                    children: const [
                      SizedBox(
                        width: 108,
                        child: Text("Best Selling", textAlign: TextAlign.right, style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18, fontFamily: 'SF Pro Text'))
                      ),
                      SizedBox(
                        width: 270,
                        child: Text("See all ", textAlign: TextAlign.right, style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16, fontFamily: 'SF Pro Text'))
                      )]
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    child: products(data))]
              );
            }
            return const Center(
                child: CircularProgressIndicator());
          })
    );
  }
}