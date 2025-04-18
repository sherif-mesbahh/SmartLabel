class BannersDatum {
  int? id;
  String? title;
  String? mainImage;

  BannersDatum({this.id, this.title, this.mainImage});

  factory BannersDatum.fromJson(Map<String, dynamic> json) => BannersDatum(
        id: json['id'] as int?,
        title: json['title'] as String?,
        mainImage: json['mainImage'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'mainImage': mainImage,
      };
}
