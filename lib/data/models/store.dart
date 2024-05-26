import 'dart:convert';

import 'package:pos/domain/entities/store.dart';

class StoreModel {
  String id;
  String? name;

  StoreModel({
    required this.id,
    this.name,
  });

  factory StoreModel.fromRawJson(String str) => StoreModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  factory StoreModel.fromEntity(StoreEntity data) => StoreModel(
    id: data.id,
    name: data.name
  );

  StoreEntity toEntity() => StoreEntity(
    id: id,
    name: name
  );
}