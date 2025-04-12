class CategorySearchDatum {
	int? id;
	String? name;
	String? imageUrl;

	CategorySearchDatum({this.id, this.name, this.imageUrl});

	factory CategorySearchDatum.fromJson(Map<String, dynamic> json) => CategorySearchDatum(
				id: json['id'] as int?,
				name: json['name'] as String?,
				imageUrl: json['imageUrl'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'imageUrl': imageUrl,
			};
}
