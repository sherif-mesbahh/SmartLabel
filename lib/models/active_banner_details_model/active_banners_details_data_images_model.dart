class ActiveBannersDetailsDataImages {
  final int? imageId;
  final String? imageUrl;

  ActiveBannersDetailsDataImages({this.imageId, this.imageUrl});

  factory ActiveBannersDetailsDataImages.fromJson(Map<String, dynamic> json) =>
      ActiveBannersDetailsDataImages(
        imageId: json['imageId'] as int?,
        imageUrl: json['imageUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'imageId': imageId,
        'imageUrl': imageUrl,
      };
}
