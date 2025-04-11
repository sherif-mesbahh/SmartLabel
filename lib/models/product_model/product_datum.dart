class ProductDatum {
  int? id;
  String? name;
  num? oldPrice;
  num? discount;
  num? newPrice;
  String? categoryName;
  dynamic imageUrl;

  ProductDatum({
    this.id,
    this.name,
    this.oldPrice,
    this.discount,
    this.newPrice,
    this.categoryName,
    this.imageUrl,
  });

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        oldPrice: json['oldPrice'] as num?,
        discount: json['discount'] as num?,
        newPrice: json['newPrice'] as num?,
        categoryName: json['categoryName'] as String?,
        imageUrl: json['imageUrl'],
      );

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
