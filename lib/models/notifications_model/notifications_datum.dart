class NotificationsDatum {
  int? id;
  bool? isRead;
  String? message;
  String? image;
  DateTime? createdAt;

  NotificationsDatum(
      {this.id, this.message, this.createdAt, this.image, this.isRead});

  factory NotificationsDatum.fromJson(Map<String, dynamic> json) =>
      NotificationsDatum(
        id: json['id'] as int?,
        isRead: json['isRead'] as bool?,
        message: json['message'] as String?,
        image: json['image'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'isRead': isRead,
        'message': message,
        'image': image,
        'createdAt': createdAt?.toIso8601String(),
      };
}
