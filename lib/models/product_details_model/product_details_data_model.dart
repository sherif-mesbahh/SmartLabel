class ProductDetailsDataModel {
  int? id;
  String? name;
  int? oldPrice;
  int? discount;
  int? newPrice;
  String? description;
  String? mainImage;
  int? categoryId;
  bool? favorite;
  List<String>? images;

  ProductDetailsDataModel({
    this.id,
    this.name,
    this.oldPrice,
    this.discount,
    this.newPrice,
    this.description,
    this.categoryId,
    this.images,
    this.mainImage,
    this.favorite,
  });

  factory ProductDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsDataModel(
        id: (json['id'] as num?)?.toInt(),
        name: json['name'] as String?,
        oldPrice: (json['oldPrice'] as num?)?.toInt(),
        discount: (json['discount'] as num?)?.toInt(),
        newPrice: (json['newPrice'] as num?)?.toInt(),
        description: json['description'] as String?,
        categoryId: json['categoryId'] as int?,
        favorite: json['favorite'],
        mainImage: json['mainImage'] as String?,
        images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'oldPrice': oldPrice,
        'discount': discount,
        'newPrice': newPrice,
        'description': description,
        'categoryId': categoryId,
        'favorite': favorite,
        'mainImage': mainImage,
        'images': images,
      };
}
