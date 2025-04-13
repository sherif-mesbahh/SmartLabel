class ActiveBannersDatum {
  int? id;
  String? title;
  String? imageUrl;

  ActiveBannersDatum({this.id, this.title, this.imageUrl});

  factory ActiveBannersDatum.fromJson(Map<String, dynamic> json) =>
      ActiveBannersDatum(
        id: json['id'] as int?,
        title: json['title'] as String?,
        imageUrl: json['imageUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'imageUrl': imageUrl,
      };
}
