import 'dart:convert';
import 'package:ecommerce_app/pages/productInfo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

class cartPage extends StatefulWidget {
  const cartPage({super.key});

  @override
  State<cartPage> createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {
  List<ProductElement> myCart = [];
  bool emptyCart = true;

  Future<List<ProductElement>> getmyCartFromcached() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> cartJson = prefs.getStringList('cart') ?? [];
      cartJson.forEach((element) {
        ProductElement productInCart =
            ProductElement.fromJson(jsonDecode(element));
        myCart.add(productInCart);
        emptyCart = false;
        setState(() {});
      });
    } catch (e) {
      print(e);
    }
    return myCart;
  }

  @override
  void initState() {
    super.initState();
    getmyCartFromcached();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
        backgroundColor: Colors.blue.shade900,
      ),
      drawer: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('profilePage');
              },
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('cartPage');
              },
              leading: const Icon(Icons.shopping_cart),
              title: const Text('View Cart'),
            ),
          ],
        ),
      ),
      body: emptyCart
          ? const Center(
              child: Text('Cart is empty'),
            )
          : ListView.builder(
              itemCount: myCart.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  productInfoPage(product: myCart[index])));
                    },
                    child: ListTile(
                        leading: Image.network(myCart[index].thumbnail!),
                        title: Text(myCart[index].title!),
                        subtitle: Text(myCart[index].price!.toString()),
                        trailing: FittedBox(
                            child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(myCart[index].rating!.toString())
                          ],
                        ))),
                  )),
    );
  }
}
