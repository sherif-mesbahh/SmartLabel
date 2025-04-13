class ActiveBannerDetailsData {
  int? id;
  String? title;
  dynamic description;
  DateTime? startDate;
  DateTime? endDate;
  String? mainImage;
  List<String>? images;

  ActiveBannerDetailsData({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.mainImage,
    this.images,
  });

  factory ActiveBannerDetailsData.fromJson(Map<String, dynamic> json) =>
      ActiveBannerDetailsData(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'],
        startDate: json['startDate'] == null
            ? null
            : DateTime.parse(json['startDate'] as String),
        endDate: json['endDate'] == null
            ? null
            : DateTime.parse(json['endDate'] as String),
        mainImage: json['mainImage'] as String?,
        images: (json['images'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'mainImage': mainImage,
        'images': images,
      };
}
