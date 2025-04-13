import 'category_datum.dart';

class CategoryModel {
  int? statusCode;
  bool? success;
  String? message;
  dynamic errors;
  List<CategoryDatum>? data;

  CategoryModel({
    this.statusCode,
    this.success,
    this.message,
    this.errors,
    this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        statusCode: json['statusCode'] as int?,
        success: json['success'] as bool?,
        message: json['message'] as String?,
        errors: json['errors'] as dynamic,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => CategoryDatum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'success': success,
        'message': message,
        'errors': errors,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
