import 'package:pos/data/data.dart';

abstract class ProductRemoteDatasource {
  Future<ProductModel?> getProduct(String userID, String storeID, String productID);
  Future<List<ProductModel>?> getProductsList(String userID, String storeID);
  Future<bool> addProduct(String userID,String storeID, ProductModel product);
  Future<bool> editProduct(String userID, String storeID, String ProductID, ProductModel product);
  Future<bool> deleteProduct(String userID, String storeID, String productID);
}