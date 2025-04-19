import 'banner_details_data_image_model.dart';

class BannerDetailsDataModel {
  int? id;
  String? title;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  String? mainImage;
  List<BannerDatailsDataImageModel>? images;

  BannerDetailsDataModel({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.mainImage,
    this.images,
  });

  factory BannerDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      BannerDetailsDataModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        startDate: json['startDate'] == null
            ? null
            : DateTime.parse(json['startDate'] as String),
        endDate: json['endDate'] == null
            ? null
            : DateTime.parse(json['endDate'] as String),
        mainImage: json['mainImage'] as String?,
        images: (json['images'] as List<dynamic>?)
                ?.map((e) => BannerDatailsDataImageModel.fromJson(
                    e as Map<String, dynamic>))
                .where(
                    (img) => img.imageUrl != null && img.imageUrl!.isNotEmpty)
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'mainImage': mainImage,
        'images': images?.map((e) => e.toJson()).toList(),
      };
}
