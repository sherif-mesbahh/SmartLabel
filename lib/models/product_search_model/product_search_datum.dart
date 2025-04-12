class ProductSearchDatum {
  int? id;
  String? name;
  int? oldPrice;
  int? discount;
  int? newPrice;
  String? categoryName;
  String? imageUrl;

  ProductSearchDatum({
    this.id,
    this.name,
    this.oldPrice,
    this.discount,
    this.newPrice,
    this.categoryName,
    this.imageUrl,
  });

  factory ProductSearchDatum.fromJson(Map<String, dynamic> json) {
    return ProductSearchDatum(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      oldPrice: (json['oldPrice'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toInt(),
      newPrice: (json['newPrice'] as num?)?.toInt(),
      categoryName: json['categoryName'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'oldPrice': oldPrice,
        'discount': discount,
        'newPrice': newPrice,
        'categoryName': categoryName,
        'imageUrl': imageUrl,
      };
}
