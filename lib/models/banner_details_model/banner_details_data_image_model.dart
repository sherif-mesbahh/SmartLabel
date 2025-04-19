class BannerDatailsDataImageModel {
  int? imageId;
  String? imageUrl;

  BannerDatailsDataImageModel({this.imageId, this.imageUrl});

  factory BannerDatailsDataImageModel.fromJson(Map<String, dynamic> json) => BannerDatailsDataImageModel(
        imageId: json['imageId'] as int?,
        imageUrl: json['imageUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'imageId': imageId,
        'imageUrl': imageUrl,
      };
}
