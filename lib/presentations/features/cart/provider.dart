import 'package:flutter/material.dart';
import 'package:pos/main.dart';

import '../../../domain/entities/cart.dart';
import '../../../domain/entities/product.dart';

class CartProvider extends ChangeNotifier {

  CartEntity? _cart;
  CartEntity? get cart => _cart;

  void _createNewCart() {
    _cart = null;
    _cart = CartEntity(
        id: uuid.v1(),
        items: [],
        createDate: DateTime.now()
    );
  }

  void decreaseProduct(ProductEntity product) {
    if(cart == null) {
      _createNewCart();
    }

    final index = _cart!.items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      if (_cart!.items[index].count > 1) {
        _cart!.items[index].count--;
      } else {
        _cart!.items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void increaseProduct(ProductEntity product) {
    if(cart == null) {
      _createNewCart();
    }

    final index = _cart!.items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _cart!.items[index].count++;
    } else {
      _cart!.items.add(CartItem(product: product, count: 1));
    }
    notifyListeners();
  }

  void removeAllProduct() {
    if(cart == null) {
      _createNewCart();
    }
    _cart!.items.clear();
    notifyListeners();
  }

  bool isProductInCart(ProductEntity product) {
    if (cart == null) {
      return false;
    }
    return cart!.items.any((item) => item.product.id == product.id);
  }

  int getProductCount(ProductEntity product) {
    if (cart == null) {
      return 0;
    }
    final index = cart!.items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      return cart!.items[index].count;
    }
    return 0;
  }


}
