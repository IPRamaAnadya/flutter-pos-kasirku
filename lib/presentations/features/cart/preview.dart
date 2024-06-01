import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pos/domain/entities/product.dart';
import 'package:pos/main.dart';
import 'package:pos/presentations/commons/styles/color.dart';
import 'package:pos/presentations/commons/styles/text.dart';
import '../../../domain/entities/cart.dart';

class CartPreview extends StatefulWidget {
  static const routeName = "cart/preview";
  const CartPreview({super.key});

  @override
  State<CartPreview> createState() => _CartPreviewState();
}

class _CartPreviewState extends State<CartPreview> {

  final CartEntity _cart = CartEntity(
    id: uuid.v4(), 
    items: List<CartItem>.generate(10, (index) => CartItem(
      product: ProductEntity(id: uuid.v4(), name: "Product $index", price: Random().nextInt(1000)),
      count: Random().nextInt(10).toInt(),
    )), 
    createDate: DateTime.now()
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang"),
        actions: [
          // delete cart
          IconButton(
            onPressed: () {
              // confirm delete dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Hapus Keranjang"),
                  content: const Text("Apakah anda yakin ingin menghapus keranjang ini?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Batal"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigator.pop(context);
                      },
                      child: const Text("Hapus"),
                    ),
                  ],
                )
              );

            },
            icon: const Icon(Icons.delete, size: 20, color: Colors.red,),
          ),
        ],
      ),
      body: Column(children: [
        Expanded(child: 
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3877751307.
          _itemsList(),
        ),
        // SUMMARY
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3077147822.
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text("Ringkasan",
                style: AppSText.title,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtotal", style: AppSText.caption,),
                  Text("Rp ${_cart.totalPrice()}", style: AppSText.caption,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Diskon", style: AppSText.caption,),
                  Text("Rp 0", style: AppSText.caption,),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: AppSText.caption,),
                  Text("Rp ${_cart.totalPrice()}", style: AppSText.title.copyWith(fontSize: 10, color: AppColor.secondary700),),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Bayar", style: AppSText.button,)
                ),
              )
            ]
          )
        ),
      ],)
    );
  }

  Widget _itemsList() {
    return GridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 1,
      childAspectRatio: 5,
      children: List.generate(
        _cart.items.length, 
        (index) => LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              child: Row(children: [
                // Photo square
                Container(
                  width: constraints.maxHeight,
                  height: constraints.maxHeight,
                  color: Colors.grey,
                ),
                SizedBox(width: 10,),
                // Expanded for display title, price, count, and total price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_cart.items[index].product.name,
                        style: AppSText.title,
                      ),
                      Text("Rp ${_cart.items[index].product.price}",
                        style: AppSText.caption,
                      ),
                      Text("x ${_cart.items[index].count}",
                        style: AppSText.caption,
                      ),
                      Text("Rp ${_cart.items[index].count * (_cart.items[index].product.price ?? 0)}",
                        style: AppSText.caption.copyWith(color: AppColor.secondary500),
                      ),
                    ],
                  ),
                ),
                // icon delete and edit
                SizedBox(width: 10,),
                Column(
                  children: [
                  Expanded(child: IconButton(
                    iconSize: 14,
                    onPressed: () {},
                    icon: const Icon(Icons.edit, size: 14,),
                  ),),
                  Expanded(child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete, size: 14),
                  ),)
                ],)
              ],),
            );
          },
        )
      )
    );
  }
}
