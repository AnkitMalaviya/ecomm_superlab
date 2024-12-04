import '../models/product_model.dart';

abstract class RepositoryBase {
  Future<List<Product>> getProducts(String query, int page);
}
