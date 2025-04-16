class ProductDatum {
  int? id;
  String? name;
  num? oldPrice;
  num? discount;
  num? newPrice;
  int? categoryId;
  String? mainImage;
  bool? favorite;

  ProductDatum({
    this.id,
    this.name,
    this.oldPrice,
    this.discount,
    this.newPrice,
    this.categoryId,
    this.mainImage,
    this.favorite,
  });

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        oldPrice: json['oldPrice'] as num?,
        discount: json['discount'] as num?,
        newPrice: json['newPrice'] as num?,
        categoryId: json['categoryId'] as int?,
        mainImage: json['mainImage'],
        favorite: json['favorite'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'oldPrice': oldPrice,
        'discount': discount,
        'newPrice': newPrice,
        'categoryId': categoryId,
        'mainImage': mainImage,
        'favorite': favorite,
      };
}
