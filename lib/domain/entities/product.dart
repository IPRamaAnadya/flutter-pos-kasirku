class ProductEntity {
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
  int? discount;

  ProductEntity({
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
    this.discount,
  });

  // calculate price with discount if discount is set
  int getPrice() {
    if(price == null) { return 0; }
    if (discount != null) {
      return (price! * (100 - discount!) / 100).toInt();
    }
    return price!;
  }

  // get the profit value based on the price (minus the discount if set) decrease by purchase price
  int getProfit() {
    if(purchasePrice == null) { return getPrice(); }
    return getPrice() - purchasePrice!;
  }
}
