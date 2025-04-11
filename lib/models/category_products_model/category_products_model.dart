import 'data.dart';

class CategoryProductsModel {
	int? statusCode;
	bool? success;
	String? message;
	dynamic errors;
	Data? data;

	CategoryProductsModel({
		this.statusCode, 
		this.success, 
		this.message, 
		this.errors, 
		this.data, 
	});

	factory CategoryProductsModel.fromJson(Map<String, dynamic> json) {
		return CategoryProductsModel(
			statusCode: json['statusCode'] as int?,
			success: json['success'] as bool?,
			message: json['message'] as String?,
			errors: json['errors'] as dynamic,
			data: json['data'] == null
						? null
						: Data.fromJson(json['data'] as Map<String, dynamic>),
		);
	}



	Map<String, dynamic> toJson() => {
				'statusCode': statusCode,
				'success': success,
				'message': message,
				'errors': errors,
				'data': data?.toJson(),
			};
}
