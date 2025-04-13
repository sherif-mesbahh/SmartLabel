import 'active_banners_datum.dart';

class AcitveBannersModel {
  int? statusCode;
  bool? success;
  String? message;
  dynamic errors;
  List<ActiveBannersDatum>? data;

  AcitveBannersModel({
    this.statusCode,
    this.success,
    this.message,
    this.errors,
    this.data,
  });

  factory AcitveBannersModel.fromJson(Map<String, dynamic> json) {
    return AcitveBannersModel(
      statusCode: json['statusCode'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as dynamic,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ActiveBannersDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'success': success,
        'message': message,
        'errors': errors,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
