class ActiveBannersDatum {
  int? id;
  String? title;
  String? mainImage;

  ActiveBannersDatum({this.id, this.title, this.mainImage});

  factory ActiveBannersDatum.fromJson(Map<String, dynamic> json) =>
      ActiveBannersDatum(
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
