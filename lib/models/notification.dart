class Notificatian {
  final int id;
  final int userId;
  final String header;
  final String message;
  final DateTime dateCreate;
  final int type;
  final int isReaded;
  final String time;

  Notificatian({
    required this.id,
    required this.userId,
    required this.dateCreate,
    required this.header,
    required this.message,
    required this.type,
    required this.isReaded,
    required this.time,
  });

  factory Notificatian.fromJson(Map<String, dynamic> json, DateTime d) {
    return Notificatian(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      header: json['header'] as String,
      message: json['message'] as String,
      type: json['type'] as int,
      isReaded: json['is_readed'] as int,
      time: json['time'] as String,
      dateCreate: d,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'date_create': dateCreate,
      'header': header,
      'message': message,
      'type': type,
      'is_readed': isReaded,
      'time': time,
    };
  }

  @override
  String toString() {
    return 'NotificationData(id: $id, userId: $userId, dateCreate: $dateCreate, header: $header, message: $message, type: $type, isReaded: $isReaded, time: $time)';
  }
}
