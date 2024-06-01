import 'dart:ffi';

import 'package:pos/domain/entities/product.dart';

class CartEntity {
  final String id;
  List<CartItem> items;
  DateTime createDate;

  CartEntity({
    required this.id,
    required this.items,
    required this.createDate,
  });

  double totalPrice() {
    double total = 0;
    if (items == null) {
      return total;
    }
    for (var item in items!) {
      total += (item.product.price ?? 0) * item.count;
    }
    return total;
  }

}

class CartItem {
  ProductEntity product;
  int count;

  CartItem({
    required this.product,
    required this.count,
  });
}
