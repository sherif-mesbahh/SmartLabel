class NotificationDetailsDataModel {
  int? type;
  int? typeId;

  NotificationDetailsDataModel({this.type, this.typeId});

  factory NotificationDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      NotificationDetailsDataModel(
        type: json['type'] as int?,
        typeId: json['typeId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'typeId': typeId,
      };
}
