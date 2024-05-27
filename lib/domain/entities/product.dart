class ProductEntity {
  String id;
  String name;
  String? otherName;
  String? skuNumber;
  String? description;
  String? photoUrl;
  int? price;
  String? unit;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductEntity({
    required this.id,
    required this.name,
    this.otherName,
    this.description,
    this.photoUrl,
    this.price,
    this.unit,
    this.skuNumber,
    this.createdAt,
    this.updatedAt,
  });
}
