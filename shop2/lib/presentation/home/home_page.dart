import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../domain/Category.dart';
import '../../domain/Product.dart';
import '../detail_page.dart';
import '../../data/categoryController.dart';
import '../../data/productController.dart';
import 'components/build_product.dart';
import 'components/category.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> productList = [];
  List<Category> categoryList = [];
  late int _pageNumber;
  late bool _loading;
  bool _isLastPage = false;
  final int _pageSize = 10;
  int _lastTotalItems = 0;
  late ScrollController _scrollController;

  Future<void> initialFetch() async {
    final ProductController productController = Get.put(ProductController());
    final CategoryController categoryController = Get.put(CategoryController());
    List<Category> listCategoryFromRequest = await categoryController.getCategories();
    List<Product> listProductsFromRequest = await productController.getProducts(_pageNumber);
    setState(() {
      _isLastPage = listProductsFromRequest.length < _pageSize;
      categoryList.addAll(listCategoryFromRequest);
      productList.addAll(listProductsFromRequest);
      _loading = false;
      _pageNumber += 1;
    });
  }

  Future<void> fetchData() async {
    _loading = true;
    final ProductController productController = Get.put(ProductController());
    List<Product> listProductsFromRequest = await productController.getProducts(_pageNumber);
    _lastTotalItems = productList.length;
    setState(() {
      _isLastPage = listProductsFromRequest.length < _pageSize;
      productList.addAll(listProductsFromRequest);
      _loading = false;
      _pageNumber += 1;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo((_lastTotalItems + (_pageNumber - 1))/2*210, duration: const Duration(microseconds: 1), curve: Curves.ease);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _pageNumber = 1;
    productList = [];
    _loading = true;
    initialFetch();
    _scrollController = ScrollController(initialScrollOffset: 5.0, keepScrollOffset: true)..addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: detailBody(categoryList, context),
        ),
      ),
    );
  }

  Column detailBody(List<Category> categories, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        section('Categories', ''),
        const SizedBox(height: 15),
        SizedBox(
          height: 120,
          child: category(categories),
        ),
        const SizedBox(height: 15),
        section('Best Selling', 'See all'),
        const SizedBox(height: 15),
        Expanded(child: category(context))
      ],
    );
  }

  Widget category(context) {
    if (_loading) {
      return const Center(
        child: Padding(padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(),),
      );
    }
    return GridView.count(
      controller: _scrollController,
      crossAxisCount: 2,
      childAspectRatio: 0.62,
      physics: const AlwaysScrollableScrollPhysics(),
      children: List.generate(productList.length, (index) {
        return GestureDetector(
          onTap: () => Get.to(() => ProductDetail(index: productList[index].id)),
          child: buildProduct(productList[index]),
        );
      }),
    );
  }
  scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        if (!_isLastPage) {
          _loading = true;
          if (_loading) {
            fetchData();
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Row section(title, param) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(
          param,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        )
      ],
    );
  }
}