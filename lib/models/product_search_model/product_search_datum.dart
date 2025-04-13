class ProductSearchDatum {
  int? id;
  String? name;
  int? oldPrice;
  int? discount;
  int? newPrice;
  int? categoryId;
  String? imageUrl;
  bool? favorite;

  ProductSearchDatum({
    this.id,
    this.name,
    this.oldPrice,
    this.discount,
    this.newPrice,
    this.categoryId,
    this.imageUrl,
    this.favorite,
  });

  factory ProductSearchDatum.fromJson(Map<String, dynamic> json) {
    return ProductSearchDatum(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      oldPrice: (json['oldPrice'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toInt(),
      newPrice: (json['newPrice'] as num?)?.toInt(),
      categoryId: json['categoryId'] as int?,
      imageUrl: json['imageUrl'] as String?,
      favorite: json['favorite'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'oldPrice': oldPrice,
        'discount': discount,
        'newPrice': newPrice,
        'categoryId': categoryId,
        'imageUrl': imageUrl,
        'favorite': favorite,
      };
}
