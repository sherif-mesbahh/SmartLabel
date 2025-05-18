
import 'package:smart_label_software_engineering/models/all_users_model/all_users_datum_model.dart';

class AllUsersModel {
  int? statusCode;
  bool? success;
  String? message;
  dynamic errors;
  List<AllUsersDatumModel>? data;

  AllUsersModel({
    this.statusCode,
    this.success,
    this.message,
    this.errors,
    this.data,
  });

  factory AllUsersModel.fromJson(Map<String, dynamic> json) => AllUsersModel(
        statusCode: json['statusCode'] as int?,
        success: json['success'] as bool?,
        message: json['message'] as String?,
        errors: json['errors'] as dynamic,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => AllUsersDatumModel.fromJson(e as Map<String, dynamic>))
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
