class FavSearchDatum {
	int? id;
	String? name;
	int? oldPrice;
	int? discount;
	int? newPrice;
	String? categoryName;
	String? imageUrl;

	FavSearchDatum({
		this.id, 
		this.name, 
		this.oldPrice, 
		this.discount, 
		this.newPrice, 
		this.categoryName, 
		this.imageUrl, 
	});

	factory FavSearchDatum.fromJson(Map<String, dynamic> json) => FavSearchDatum(
				id: json['id'] as int?,
				name: json['name'] as String?,
				oldPrice: json['oldPrice'] as int?,
				discount: json['discount'] as int?,
				newPrice: json['newPrice'] as int?,
				categoryName: json['categoryName'] as String?,
				imageUrl: json['imageUrl'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'oldPrice': oldPrice,
				'discount': discount,
				'newPrice': newPrice,
				'categoryName': categoryName,
				'imageUrl': imageUrl,
			};
}
