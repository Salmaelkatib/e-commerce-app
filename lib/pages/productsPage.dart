import 'package:ecommerce_app/pages/productInfo.dart';
import 'package:ecommerce_app/services/product_services.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class productsPage extends StatefulWidget {
  const productsPage({super.key});

  @override
  State<productsPage> createState() => _productsPageState();
}

class _productsPageState extends State<productsPage> {
  Product? products;
  bool loading = true;

  getMyProducts() async {
    products = await ProductService().getProducts();
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMyProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: products?.products?.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => productInfoPage(
                                  product: products!.products![index])));
                    },
                    child: ListTile(
                        leading: Image.network(
                            products!.products![index].thumbnail!),
                        title: Text(products!.products![index].title!),
                        subtitle:
                            Text(products!.products![index].price!.toString()),
                        trailing: FittedBox(
                            child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(products!.products![index].rating!.toString())
                          ],
                        ))),
                  )),
    );
  }
}
