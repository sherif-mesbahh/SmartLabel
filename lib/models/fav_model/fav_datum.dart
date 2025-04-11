class FavDatum {
  int? id;
  String? name;
  int? oldPrice;
  int? discount;
  int? newPrice;
  String? categoryName;
  String? imageUrl;

  FavDatum({
    this.id,
    this.name,
    this.oldPrice,
    this.discount,
    this.newPrice,
    this.categoryName,
    this.imageUrl,
  });

  factory FavDatum.fromJson(Map<String, dynamic> json) => FavDatum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        oldPrice: (json['oldPrice'] is int)
            ? json['oldPrice'] as int
            : (json['oldPrice'] as num?)?.toInt(),
        discount: (json['discount'] is int)
            ? json['discount'] as int
            : (json['discount'] as num?)?.toInt(),
        newPrice: (json['newPrice'] is int)
            ? json['newPrice'] as int
            : (json['newPrice'] as num?)?.toInt(),
        categoryName: json['categoryName'] as String?,
        imageUrl: json['imageUrl'] as String?,
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
