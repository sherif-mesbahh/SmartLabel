import 'category_products_data_product_model.dart';

class CategoryProductsDataModel {
  int? id;
  String? name;
  String? imageUrl;
  List<CategoryProductsDataProductModel>? products;

  CategoryProductsDataModel({this.id, this.name, this.imageUrl, this.products});

  factory CategoryProductsDataModel.fromJson(Map<String, dynamic> json) =>
      CategoryProductsDataModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        imageUrl: json['imageUrl'] as String?,
        products: (json['products'] as List<dynamic>?)
            ?.map((e) => CategoryProductsDataProductModel.fromJson(
                e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'products': products?.map((e) => e.toJson()).toList(),
      };
}
