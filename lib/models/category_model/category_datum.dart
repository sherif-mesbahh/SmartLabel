class CategoryDatum {
  int? id;
  String? name;
  String? imageUrl;

  CategoryDatum({this.id, this.name, this.imageUrl});

  factory CategoryDatum.fromJson(Map<String, dynamic> json) => CategoryDatum(
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
