import 'notifications_datum.dart';

class NotificationsModel {
  int? statusCode;
  bool? success;
  String? message;
  dynamic errors;
  List<NotificationsDatum>? data;

  NotificationsModel({
    this.statusCode,
    this.success,
    this.message,
    this.errors,
    this.data,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      statusCode: json['statusCode'] as int?,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as dynamic,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => NotificationsDatum.fromJson(e as Map<String, dynamic>))
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
