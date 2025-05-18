import 'notification_details_data_model.dart';

class NotificationDetailsModel {
  int? statusCode;
  bool? success;
  String? message;
  dynamic errors;
  NotificationDetailsDataModel? data;

  NotificationDetailsModel({
    this.statusCode,
    this.success,
    this.message,
    this.errors,
    this.data,
  });

  factory NotificationDetailsModel.fromJson(Map<String, dynamic> json) {
    return NotificationDetailsModel(
      statusCode: json['statusCode'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as dynamic,
      data: json['data'] == null
          ? null
          : NotificationDetailsDataModel.fromJson(
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
