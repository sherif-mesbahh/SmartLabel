import 'category_search_datum.dart';

class CategorySearchModel {
	List<CategorySearchDatum>? data;
	int? page;
	int? pageSize;
	int? totalCount;
	bool? hasPreviousPage;
	bool? hasNextPage;

	CategorySearchModel({
		this.data, 
		this.page, 
		this.pageSize, 
		this.totalCount, 
		this.hasPreviousPage, 
		this.hasNextPage, 
	});

	factory CategorySearchModel.fromJson(Map<String, dynamic> json) {
		return CategorySearchModel(
			data: (json['data'] as List<dynamic>?)
						?.map((e) => CategorySearchDatum.fromJson(e as Map<String, dynamic>))
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
