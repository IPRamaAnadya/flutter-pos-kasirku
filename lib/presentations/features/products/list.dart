import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/core/utils/extension_int_currency.dart';
import 'package:pos/presentations/commons/styles/color.dart';
import 'package:pos/presentations/commons/styles/text.dart';
import 'package:pos/presentations/features/products/provider.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  static const routeName = "product/all";
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  late ProductProvider _productProvider;

  TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    Future.microtask(() {
      _productProvider = Provider.of<ProductProvider>(context, listen: false);
      _productProvider.getProductsList();
    });
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _productProvider.searchProducts(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Consumer<ProductProvider>(
          builder: (context, data, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  _productProvider.getProductsList();
                },
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(1.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(1.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(1.0),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),

                                hintText: 'Cari barang',
                                suffixIcon: _searchController.text.isNotEmpty
                                    ? IconButton(
                                  onPressed: () {
                                    _searchController.clear(); // Clear the text field on tap
                                  },
                                  icon: Icon(Icons.clear), // Use the clear icon
                                )
                                    : null, // Hide the icon when text field is empty
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1),
                              color: AppColor.secondary200
                            ),
                            child: Center(
                              child: Icon(Icons.barcode_reader, color: AppColor.primary700,),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.65,
                        children: data.products.map((product) {
                          return Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1),
                              border: Border.all(color: Colors.grey.withOpacity(0.1)),
                              color: Colors.white
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // PHOTO
                                    Container(
                                      width: double.infinity,
                                      height: constraints.maxWidth,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: Image.network(product.photoUrl ?? "",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    // NAME
                                    Text(product.name ?? "-",
                                      style: AppSText.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 5,),
                                    Text("${(product.price ?? 0).toRupiah}",
                                      style: AppSText.title.copyWith(color: AppColor.secondary500),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 5,),
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){
                                            HapticFeedback.lightImpact();
                                          },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.primary700,
                                            borderRadius: BorderRadius.circular(1)
                                          ),
                                          child: Center(child: Text("Tambah",
                                            style: AppSText.body.copyWith(color: Colors.white),
                                          )),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            )
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },),
      ),
    );
  }
}
