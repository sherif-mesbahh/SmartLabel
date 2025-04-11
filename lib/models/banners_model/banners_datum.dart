class BannersDatum {
	int? id;
	String? title;
	String? imageUrl;

	BannersDatum({this.id, this.title, this.imageUrl});

	factory BannersDatum.fromJson(Map<String, dynamic> json) => BannersDatum(
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
