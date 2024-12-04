import '../../data/models/product_model.dart';
import '../../data/repositories/repository_base.dart';

class GetProductsUseCase {
  final RepositoryBase repository;

  GetProductsUseCase(this.repository);

  Future<List<Product>> execute(String query, int page) async {
    return await repository.getProducts(query, page);
  }
}
