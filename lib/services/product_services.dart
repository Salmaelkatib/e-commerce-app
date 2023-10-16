import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductService {
  String endpoint = "https://dummyjson.com/products";
  final dio = Dio();
  Product? products;

  Future<Product?> getProducts() async {
    try {
      var response = await dio.get(endpoint);
      products = Product.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return products;
  }
}
