class NotificationsDatum {
  int? id;
  String? message;
  DateTime? createdAt;

  NotificationsDatum({this.id, this.message, this.createdAt});

  factory NotificationsDatum.fromJson(Map<String, dynamic> json) => NotificationsDatum(
        id: json['id'] as int?,
        message: json['message'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message,
        'createdAt': createdAt?.toIso8601String(),
      };
}
