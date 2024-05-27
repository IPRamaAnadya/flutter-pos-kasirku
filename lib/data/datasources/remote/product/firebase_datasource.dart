import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos/data/datasources/remote/product/datasource.dart';
import 'package:pos/data/models/product.dart';

class ProductFBDatasource implements ProductRemoteDatasource {

  @override
  Future<bool> addProduct(String userID, String storeID, ProductModel product) =>
      FirebaseFirestore.instance
          .collection("users").doc(userID)
          .collection("stores").doc(storeID)
          .collection("products").doc(product.id).set(product.toJson())
            .then((res) {
            return true;
            })
            .catchError((err) {
              return false;
            });

  @override
  Future<bool> deleteProduct(String userID, String storeID, String productID) =>
      FirebaseFirestore.instance
          .collection("users").doc(userID)
          .collection("stores").doc(storeID)
          .collection("products").doc(productID).delete()
          .then((res) {
            return true;
          })
          .catchError((err) {
            return false;
          });

  @override
  Future<bool> editProduct(String userID, String storeID, String ProductID, ProductModel product) =>
      FirebaseFirestore.instance
          .collection("users").doc(userID)
          .collection("stores").doc(storeID)
          .collection("products").doc(product.id).update(product.toJson())
          .then((res) {
            return true;
          })
          .catchError((err) {
            return false;
          });

  @override
  Future<ProductModel?> getProduct(String userID, String storeID, String productID) async {
    return products.first;
  }

  @override
  Future<List<ProductModel>?> getProductsList(String userID, String storeID) async {

    try {
      final storesCollection = FirebaseFirestore.instance.collection("users").doc(userID).collection("stores").doc(storeID).collection("products");
      QuerySnapshot querySnapshot = await storesCollection.get();


      List<ProductModel> data = [];

      for (var doc in querySnapshot.docs) {
        data.add(ProductModel.fromJson(doc.data() as Map<String, dynamic>));
      }

      return data;
    } catch (e) {
      throw Exception("Gagal mengambil list store: $e");
    }
  }


  List<ProductModel> products = [
    ProductModel(
      id: "1",
      name: "Kue Cubit",
      otherName: "Mini Pancake",
      description: "Kue kecil yang lembut dan manis, sering disajikan dengan berbagai topping.",
      photoUrl: "https://example.com/kue_cubit.jpg",
      price: 10000,
      unit: "RP",
      skuNumber: "SKU001",
    ),
    ProductModel(
      id: "2",
      name: "Keripik Singkong",
      otherName: "Cassava Chips",
      description: "Keripik renyah yang terbuat dari singkong, sering diberi rasa pedas atau manis.",
      photoUrl: "https://example.com/keripik_singkong.jpg",
      price: 8000,
      unit: "RP",
      skuNumber: "SKU002",
    ),
    ProductModel(
      id: "3",
      name: "Rengginang",
      description: "Kerupuk yang terbuat dari nasi yang dikeringkan dan digoreng, memiliki tekstur yang renyah.",
      photoUrl: "https://example.com/rengginang.jpg",
      price: 12000,
      unit: "RP",
      skuNumber: "SKU003",
    ),
    ProductModel(
      id: "4",
      name: "Kue Lapis",
      otherName: "Layer Cake",
      description: "Kue berlapis dengan tekstur kenyal dan rasa manis, biasanya disajikan dalam berbagai warna.",
      photoUrl: "https://example.com/kue_lapis.jpg",
      price: 15000,
      unit: "RP",
      skuNumber: "SKU004",
    ),
    ProductModel(
      id: "5",
      name: "Onde-Onde",
      description: "Kue bulat yang terbuat dari tepung ketan dan diisi dengan kacang hijau, ditaburi wijen di luar.",
      photoUrl: "https://example.com/onde_onde.jpg",
      price: 5000,
      unit: "RP",
      skuNumber: "SKU005",
    ),
    ProductModel(
      id: "6",
      name: "Kacang Atom",
      description: "Kacang tanah yang dilapisi dengan tepung dan digoreng hingga renyah.",
      photoUrl: "https://example.com/kacang_atom.jpg",
      price: 6000,
      unit: "RP",
      skuNumber: "SKU006",
    ),
    ProductModel(
      id: "7",
      name: "Bakpia",
      description: "Kue berbentuk bulat pipih yang diisi dengan kacang hijau atau coklat.",
      photoUrl: "https://example.com/bakpia.jpg",
      price: 20000,
      unit: "RP",
      skuNumber: "SKU007",
    ),
    ProductModel(
      id: "8",
      name: "Kue Putu",
      description: "Kue tradisional yang terbuat dari tepung beras dan diisi dengan gula merah, dimasak dalam bambu.",
      photoUrl: "https://example.com/kue_putu.jpg",
      price: 7000,
      unit: "RP",
      skuNumber: "SKU008",
    ),
    ProductModel(
      id: "9",
      name: "Martabak Manis",
      otherName: "Sweet Martabak",
      description: "Pancake tebal yang diisi dengan berbagai bahan seperti coklat, keju, dan kacang.",
      photoUrl: "https://example.com/martabak_manis.jpg",
      price: 25000,
      unit: "RP",
      skuNumber: "SKU009",
    ),
    ProductModel(
      id: "10",
      name: "Lupis",
      description: "Kue yang terbuat dari beras ketan, dibentuk seperti segitiga, dan disajikan dengan parutan kelapa dan gula merah.",
      photoUrl: "https://example.com/lupis.jpg",
      price: 10000,
      unit: "RP",
      skuNumber: "SKU010",
    ),
  ];

}