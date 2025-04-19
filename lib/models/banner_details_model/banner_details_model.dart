import 'banner_details_data_model.dart';

class BannerDetailsModel {
  int? statusCode;
  bool? success;
  String? message;
  dynamic errors;
  BannerDetailsDataModel? data;

  BannerDetailsModel({
    this.statusCode,
    this.success,
    this.message,
    this.errors,
    this.data,
  });

  factory BannerDetailsModel.fromJson(Map<String, dynamic> json) {
    return BannerDetailsModel(
      statusCode: json['statusCode'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as dynamic,
      data: json['data'] == null
          ? null
          : BannerDetailsDataModel.fromJson(json['data'] as Map<String, dynamic>),
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
