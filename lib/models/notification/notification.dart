class NotificationMessage {
  int? id;
  String? body;
  String? title;
  String? createdAt;
  String? read;

  NotificationMessage({this.id, this.body, this.title, this.createdAt, this.read});

  NotificationMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    title = json['title'];
    createdAt = json['created_at'];
    read = json['read'];
  }

  Map<String, dynamic> toJson() => {'id': id, 'body': body, 'title': title, 'created_at': createdAt, 'read': read};

  Map<String, dynamic> toMap() => {'id': id, 'body': body, 'title': title, 'created_at': createdAt, 'read': read};

  NotificationMessage.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    body = map['body'];
    title = map['title'];
    createdAt = map['created_at'];
    read = map['read'];
  }
}
