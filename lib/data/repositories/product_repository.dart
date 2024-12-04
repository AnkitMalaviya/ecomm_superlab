import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants/app_url.dart';
import '../../data/models/product_model.dart';
import 'repository_base.dart';

class ProductRepository implements RepositoryBase {
  @override
  Future<List<Product>> getProducts(String query, int page) async {
    print("gdfgljkfglkjfglkf");
    print(page);
    final response = await http.get(
      Uri.parse('${AppUrl.baseUrl}${AppUrl.Product}?q=${query}&page=${page ?? 1}'),
    );
    print(response.request?.url);
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data']['products'] as List).map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
