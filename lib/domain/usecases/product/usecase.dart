import 'package:pos/data/repositories/product/repository.dart';
import 'package:pos/domain/entities/product.dart';

class ProductUsecase {
  final ProductRepository _repository;
  ProductUsecase(this._repository);

  Future<List<ProductEntity>?> getProductsList() => _repository.getProductsList();
}