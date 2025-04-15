import 'login_data_model.dart';

class LoginModel {
  int? statusCode;
  bool? success;
  String? message;
  dynamic errors;
  LoginDataModel? data;

  LoginModel({
    this.statusCode,
    this.success,
    this.message,
    this.errors,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        statusCode: json['statusCode'] as int?,
        success: json['success'] as bool?,
        message: json['message'] as String?,
        errors: json['errors'] as dynamic,
        data: json['data'] == null
            ? null
            : LoginDataModel.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'success': success,
        'message': message,
        'errors': errors,
        'data': data?.toJson(),
      };
}
