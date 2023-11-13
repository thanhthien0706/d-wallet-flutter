class NotificationModel {
  int id;
  String createdAt;
  String title;
  String content;
  bool seenByUser;
  String type;
  int transactionId;

  NotificationModel(
      {required this.id,
      required this.createdAt,
      required this.title,
      required this.content,
      required this.seenByUser,
      required this.type,
      required this.transactionId});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        id: json["id"] as int,
        createdAt: json["createdAt"] as String,
        title: json["title"] as String,
        content: json["content"] as String,
        seenByUser: json["seenByUser"] as bool,
        type: json["type"] as String,
        transactionId: json["transactionId"] as int);
  }
}
