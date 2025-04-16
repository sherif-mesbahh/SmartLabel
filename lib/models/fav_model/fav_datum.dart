class FavDatum {
  int? id;
  String? name;
  int? oldPrice;
  int? discount;
  int? newPrice;
  int? categroyId;
  bool? favorite;
  String? mainImage;

  FavDatum({
    this.id,
    this.name,
    this.oldPrice,
    this.discount,
    this.newPrice,
    this.categroyId,
    this.mainImage,
    this.favorite,
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
        categroyId: json['categoryId'] as int?,
        favorite: json['favorite'],
        mainImage: json['mainImage'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'oldPrice': oldPrice,
        'discount': discount,
        'newPrice': newPrice,
        'categoryId': categroyId,
        'favorite': favorite,
        'mainImage': mainImage,
      };
}
