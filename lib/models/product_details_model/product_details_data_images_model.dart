class ProductDetailsDataImagesModel {
  final int? imageId;
  final String? imageUrl;

  ProductDetailsDataImagesModel({
    this.imageId,
    this.imageUrl,
  });

  factory ProductDetailsDataImagesModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsDataImagesModel(
      imageId: json['imageId'] as int?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'imageId': imageId,
        'imageUrl': imageUrl,
      };
}
