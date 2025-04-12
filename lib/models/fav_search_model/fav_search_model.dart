import 'fav_search_datum.dart';

class FavSearchModel {
	List<FavSearchDatum>? data;
	int? page;
	int? pageSize;
	int? totalCount;
	bool? hasPreviousPage;
	bool? hasNextPage;

	FavSearchModel({
		this.data, 
		this.page, 
		this.pageSize, 
		this.totalCount, 
		this.hasPreviousPage, 
		this.hasNextPage, 
	});

	factory FavSearchModel.fromJson(Map<String, dynamic> json) {
		return FavSearchModel(
			data: (json['data'] as List<dynamic>?)
						?.map((e) => FavSearchDatum.fromJson(e as Map<String, dynamic>))
						.toList(),
			page: json['page'] as int?,
			pageSize: json['pageSize'] as int?,
			totalCount: json['totalCount'] as int?,
			hasPreviousPage: json['hasPreviousPage'] as bool?,
			hasNextPage: json['hasNextPage'] as bool?,
		);
	}



	Map<String, dynamic> toJson() => {
				'data': data?.map((e) => e.toJson()).toList(),
				'page': page,
				'pageSize': pageSize,
				'totalCount': totalCount,
				'hasPreviousPage': hasPreviousPage,
				'hasNextPage': hasNextPage,
			};
}
