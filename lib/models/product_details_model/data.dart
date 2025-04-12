class Data {
  int? id;
  String? name;
  int? oldPrice;
  int? discount;
  int? newPrice;
  String? description;
  dynamic categoryName;
  List<String>? images;

  Data({
    this.id,
    this.name,
    this.oldPrice,
    this.discount,
    this.newPrice,
    this.description,
    this.categoryName,
    this.images,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: (json['id'] as num?)?.toInt(),
        name: json['name'] as String?,
        oldPrice: (json['oldPrice'] as num?)?.toInt(),
        discount: (json['discount'] as num?)?.toInt(),
        newPrice: (json['newPrice'] as num?)?.toInt(),
        description: json['description'] as String?,
        categoryName: json['categoryName'],
        images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'oldPrice': oldPrice,
        'discount': discount,
        'newPrice': newPrice,
        'description': description,
        'categoryName': categoryName,
        'images': images,
      };
}
