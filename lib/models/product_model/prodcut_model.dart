import 'product_datum.dart';

class ProdcutModel {
  int? statusCode;
  bool? success;
  String? message;
  dynamic errors;
  List<ProductDatum>? data;

  ProdcutModel({
    this.statusCode,
    this.success,
    this.message,
    this.errors,
    this.data,
  });

  factory ProdcutModel.fromJson(Map<String, dynamic> json) => ProdcutModel(
        statusCode: json['statusCode'] as int?,
        success: json['success'] as bool?,
        message: json['message'] as String?,
        errors: json['errors'] as dynamic,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => ProductDatum.fromJson(e as Map<String, dynamic>))
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
