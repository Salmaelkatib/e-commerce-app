import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class productInfoPage extends StatefulWidget {
  ProductElement product;

  productInfoPage({super.key, required this.product});

  @override
  State<productInfoPage> createState() => _productInfoPageState();
}

class _productInfoPageState extends State<productInfoPage> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CarouselSlider.builder(
                itemCount: widget.product.images!.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  final img = widget.product.images![index];
                  return buildImage(img, index);
                },
                options: CarouselOptions(
                    height: 250,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) => setState(
                          () => activeIndex = index,
                        )),
              ),
            ]),
            const SizedBox(height: 32),
            buildIndicator(),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Text(widget.product.title!,
                    style: const TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 20,
                      color: Colors.black,
                    )),
                const SizedBox(
                  width: 50,
                ),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text(widget.product.rating.toString())
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Text(
                  'Price: ${widget.product.price.toString()}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 50,
                ),
                Text(
                  'Discount: ${widget.product.discountPercentage.toString()}',
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text('id:  ${widget.product.id.toString()}'),
            const SizedBox(
              height: 10,
            ),
            Text('Product description:  ${widget.product.description}'),
            const SizedBox(
              height: 10,
            ),
            Text('Stock: ${widget.product.stock.toString()}'),
            const SizedBox(
              height: 10,
            ),
            Text('Brand: ${widget.product.brand}'),
            const SizedBox(
              height: 10,
            ),
            Text('Category: ${widget.product.category}'),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.blue.shade900,
                onPressed: () async {
                  addToCart(widget.product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Item added to cart'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const FittedBox(
                    child: Row(children: [
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  Text('Add to Cart', style: TextStyle(color: Colors.white))
                ])),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.blue.shade900,
                onPressed: () async {
                  RemoveFromCart(widget.product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Item removed from cart'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const FittedBox(
                    child: Row(children: [
                  Icon(
                    Icons.remove_shopping_cart,
                    color: Colors.white,
                  ),
                  Text('Remove From Cart',
                      style: TextStyle(color: Colors.white))
                ])),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String img, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.network(
          img,
          fit: BoxFit.cover,
        ),
      );

  Widget buildIndicator() => Center(
          child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.product.images!.length,
        effect: SlideEffect(
          activeDotColor: Colors.blue.shade900,
          dotColor: Colors.grey,
          dotHeight: 20,
          dotWidth: 20,
        ),
      ));

  Future<void> addToCart(ProductElement product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartJson = prefs.getStringList('cart') ?? [];

    // add a new product to the cart
    String productJson = jsonEncode(product.toJson());
    cartJson.add(productJson);

    //cache updated cart
    prefs.setStringList('cart', cartJson);
  }

  Future<void> RemoveFromCart(ProductElement product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartJson = prefs.getStringList('cart') ?? [];

    // add a new product to the cart
    String productJson = jsonEncode(product.toJson());
    cartJson.remove(productJson);

    //cache updated cart
    prefs.setStringList('cart', cartJson);
  }
}
