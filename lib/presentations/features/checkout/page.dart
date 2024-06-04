import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pos/domain/entities/cart.dart';
import 'package:pos/domain/entities/product.dart';
import 'package:pos/main.dart';

import '../../commons/styles/text.dart';

class CheckoutPage extends StatefulWidget {
  static const routeName = '/checkout';
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  final CartEntity _cart = CartEntity(
    id: uuid.v4(), 
    items: List<CartItem>.generate(10, (index) => CartItem(
      product: ProductEntity(id: uuid.v4(), name: "Product $index", price: Random().nextInt(1000)),
      count: Random().nextInt(10).toInt(),
    )), 
    createDate: DateTime.now()
  );

  int _totalPrice = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(text: TextSpan(
                text: 'Nama pembeli',
                style: AppSText.label,
              )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5.0, left: 20, right: 20),
              child: TextFormField(
                            controller: null,
                            decoration: InputDecoration(
                              hintText: "Masukkan nama Tokomu",
                              hintStyle: AppSText.hint,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            style: TextStyle(height: 1.0),
                          ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(text: TextSpan(
                text: 'Ringkasan transaksi',
                style: AppSText.label,
              )),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.only(top: 5.0, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(children: [
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
                    Text("Rp ${_cart.totalPrice()}", style: AppSText.caption),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Dibayar", style: AppSText.caption,),
                    Container(
                      width: 200,
                      height: 35,
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              _totalPrice = int.parse(value) - _cart.totalPrice().toInt();
                            });
                          }
                        },
                        textAlign: TextAlign.end,
                        controller: null,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(right: 10),
                          hintText: "Masukkan jml pembayaran",
                          hintStyle: AppSText.caption,
                          border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 2.0,
                                ),
                              ),
                        )
                      )
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total", style: AppSText.caption,),
                    Text("Rp ${_totalPrice}", style: AppSText.title),
                  ],
                ),
              ],),
            )
          ],),),
        ),
      ),
    );
  }
}