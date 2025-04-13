class Product {
  int? id;
  String? name;
  int? oldPrice;
  int? discount;
  int? newPrice;
  int? categoryId;
  bool? favorite;
  String? imageUrl;

  Product({
    this.id,
    this.name,
    this.oldPrice,
    this.discount,
    this.newPrice,
    this.categoryId,
    this.favorite,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int?,
        name: json['name'] as String?,
        oldPrice: _convertToInt(json['oldPrice']),
        discount: _convertToInt(json['discount']),
        newPrice: _convertToInt(json['newPrice']),
        categoryId: json['categoryId'] as int?,
        favorite: json['favorite'] as bool?,
        imageUrl: json['imageUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'oldPrice': oldPrice,
        'discount': discount,
        'newPrice': newPrice,
        'categoryId': categoryId,
        'favorite': favorite,
        'imageUrl': imageUrl,
      };

  // Helper function to handle the conversion
  static int? _convertToInt(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value;
    }
    if (value is double) {
      return value.toInt();
    }
    return null; // or throw an exception if you prefer
  }
}
