class RegisterModel {
  int? statusCode;
  bool? success;
  String? message;
  dynamic errors;
  dynamic data;

  RegisterModel({
    this.statusCode,
    this.success,
    this.message,
    this.errors,
    this.data,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        statusCode: json['statusCode'] as int?,
        success: json['success'] as bool?,
        message: json['message'] as String?,
        errors: json['errors'] as dynamic,
        data: json['data'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'success': success,
        'message': message,
        'errors': errors,
        'data': data,
      };
}
