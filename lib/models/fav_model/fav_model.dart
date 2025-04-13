import 'fav_datum.dart';

class FavModel {
  int? statusCode;
  bool? success;
  String? message;
  dynamic errors;
  List<FavDatum>? data;

  FavModel({
    this.statusCode,
    this.success,
    this.message,
    this.errors,
    this.data,
  });

  factory FavModel.fromJson(Map<String, dynamic> json) => FavModel(
        statusCode: json['statusCode'] as int?,
        success: json['success'] as bool?,
        message: json['message'] as String?,
        errors: json['errors'] as dynamic,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => FavDatum.fromJson(e as Map<String, dynamic>))
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
