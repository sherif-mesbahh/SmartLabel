import 'user_info_data_model.dart';

class UserInfoModel {
  int? statusCode;
  bool? success;
  String? message;
  dynamic errors;
  UserInfoDataModel? data;

  UserInfoModel({
    this.statusCode,
    this.success,
    this.message,
    this.errors,
    this.data,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        statusCode: json['statusCode'] as int?,
        success: json['success'] as bool?,
        message: json['message'] as String?,
        errors: json['errors'] as dynamic,
        data: json['data'] == null
            ? null
            : UserInfoDataModel.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'success': success,
        'message': message,
        'errors': errors,
        'data': data?.toJson(),
      };
}
