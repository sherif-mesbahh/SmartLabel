import 'active_banner_details_data.dart';

class ActiveBannerDetailsModel {
  int? statusCode;
  bool? success;
  String? message;
  dynamic errors;
  ActiveBannerDetailsData? data;

  ActiveBannerDetailsModel({
    this.statusCode,
    this.success,
    this.message,
    this.errors,
    this.data,
  });

  factory ActiveBannerDetailsModel.fromJson(Map<String, dynamic> json) {
    return ActiveBannerDetailsModel(
      statusCode: json['statusCode'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as dynamic,
      data: json['data'] == null
          ? null
          : ActiveBannerDetailsData.fromJson(
              json['data'] as Map<String, dynamic>),
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
