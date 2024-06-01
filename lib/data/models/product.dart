import 'dart:convert';

import '../../domain/entities/product.dart';

class ProductModel {
  String id;
  String name;
  String? otherName;
  String? skuNumber;
  String? description;
  String? photoUrl;
  int? purchasePrice;
  int? price;
  String? unit;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isFavorite;
  int? discount;

  ProductModel({
    required this.id,
    required this.name,
    this.otherName,
    this.description,
    this.photoUrl,
    this.purchasePrice,
    this.price,
    this.unit,
    this.skuNumber,
    this.createdAt,
    this.updatedAt,
    this.isFavorite,
    this.discount,
  }) {
    unit ??= "Rp.";
  }

  factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    otherName: json["other_name"],
    description: json["description"],
    photoUrl: json["photoURL"],
    purchasePrice: json["purchase_price"],
    price: json["price"],
    unit: json["unit"],
    skuNumber: json["sku_number"],
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["created_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    isFavorite: json["is_favorite"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "other_name": otherName,
    "description": description,
    "photoURL": photoUrl,
    "purchase_price": purchasePrice,
    "price": price,
    "unit": unit,
    "sku_number": skuNumber,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "is_favorite": isFavorite,
    "discount": discount,
  };

  // Mapping method from ProductEntity
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      otherName: entity.otherName,
      description: entity.description,
      photoUrl: entity.photoUrl,
      price: entity.price,
      unit: entity.unit,
      skuNumber: entity.skuNumber,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      discount: entity.discount,
    );
  }

  // Mapping method to ProductEntity
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      otherName: otherName ?? '',
      description: description ?? '',
      photoUrl: photoUrl ?? '',
      purchasePrice: purchasePrice ?? 0,
      price: price ?? 0,
      unit: unit ?? 'RP',
      skuNumber: skuNumber,
      createdAt: createdAt,
      updatedAt: updatedAt,
      discount: discount ?? 0,
    );
  }
}
