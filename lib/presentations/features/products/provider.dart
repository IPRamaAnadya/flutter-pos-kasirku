import 'package:flutter/cupertino.dart';
import 'package:pos/domain/usecases/product/usecase.dart';

import '../../../domain/entities/product.dart';

class ProductProvider extends ChangeNotifier {

  final ProductUsecase _productUsecase;
  ProductProvider(this._productUsecase);

  List<ProductEntity> _products = [];
  List<ProductEntity> _allProducts = [];
  List<ProductEntity> get products => _products;

  void getProductsList() async {
    _allProducts = await _productUsecase.getProductsList() ?? [];
    _products = _allProducts;
    notifyListeners();
  }

  // Sorting methods
  void sortProductsByPrice({bool ascending = true}) {
    _products.sort((a, b) {
      if (ascending) {
        return a.price!.compareTo(b.price!);
      } else {
        return b.price!.compareTo(a.price!);
      }
    });
    notifyListeners();
  }

  void sortProductsByName({bool ascending = true}) {
    _products.sort((a, b) {
      if (ascending) {
        return a.name.compareTo(b.name);
      } else {
        return b.name.compareTo(a.name);
      }
    });
    notifyListeners();
  }

  // Search method
  void searchProducts(String query) {
    if (query.isEmpty) {
      _products = _allProducts;
    } else {
      _products = _allProducts.where((product) {
        final lowerQuery = query.toLowerCase();
        final nameMatches = product.name.toLowerCase().contains(lowerQuery);
        final otherNameMatches = product.otherName?.toLowerCase().contains(lowerQuery) ?? false;
        final skuMatches = product.skuNumber?.toLowerCase().contains(lowerQuery) ?? false;
        return nameMatches || otherNameMatches || skuMatches;
      }).toList();
    }
    notifyListeners();
  }

}