import 'package:flutter/material.dart';
import 'package:pos/presentations/commons/styles/color.dart';
import 'package:pos/presentations/commons/styles/images.dart';
import 'package:pos/presentations/commons/styles/text.dart';
import 'package:pos/presentations/features/stores/create_store/provider.dart';
import 'package:provider/provider.dart';

class CreateStorePage extends StatefulWidget {
  static const routeName = "/store/create";
  const CreateStorePage({super.key});

  @override
  State<CreateStorePage> createState() => _CreateStorePageState();
}

class _CreateStorePageState extends State<CreateStorePage> {

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                // HEADER
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.building),
                      Text("Buka Toko",
                        style: AppSText.heading1.copyWith(color: AppColor.secondary500),
                      ),
                      SizedBox(height: 20,),
                      Text("Kasirku siap melayani toko pertama mu",
                        style: AppSText.body,
                      ),
          
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          textAlign: TextAlign.center,
                          controller: _controller,
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
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) return Colors.grey.withOpacity(0.2);
                          return Colors.grey; // Defer to the widget's default.
                        },
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: (){
                      if(_controller.text.trim() == "") {
                        return;
                      }
                      Provider.of<CreateStoreProvider>(context, listen: false).createStore(_controller.text.trim());
                    },
                    child: Text("Daftar",
                        style: AppSText.button,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
