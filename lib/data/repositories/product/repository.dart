import 'package:firebase_auth/firebase_auth.dart';
import 'package:pos/data/datasources/remote/product/datasource.dart';
import 'package:pos/domain/entities/product.dart';

import '../../data.dart';
import '../../datasources/local/stores/datasource.dart';

abstract class ProductRepository {
  Future<ProductEntity?> getProduct(String productID);
  Future<List<ProductEntity>?> getProductsList();
  Future<bool> addProduct(ProductModel product);
  Future<bool> editProduct(String ProductID, ProductModel product);
  Future<bool> deleteProduct(String productID);
}

class ProductRepositoryImpl implements ProductRepository {

  final ProductRemoteDatasource _remoteProduct;
  final StoreLocalDatasource _localStore;
  ProductRepositoryImpl(this._remoteProduct, this._localStore);

  @override
  Future<bool> addProduct(ProductModel product) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteProduct(String productID) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<bool> editProduct(String ProductID, ProductModel product) {
    // TODO: implement editProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductEntity?> getProduct(String productID) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>?> getProductsList() async {

    try {

      final userID = FirebaseAuth.instance.currentUser?.uid;

      if(userID == null) {
        throw Exception();
      }

      final store = await _localStore.getStore();
      final storeID = store?.id;

      if(storeID == null) {
        throw Exception();
      }

      final products = await _remoteProduct.getProductsList(userID, storeID);

      if(products == null) {
        return null;
      }

      final productEtt = List<ProductEntity>.from(products.map((product) => product.toEntity()));

      return productEtt;

    } catch (e) {
      print("### ${e}");
      throw Exception();
    }

  }

}