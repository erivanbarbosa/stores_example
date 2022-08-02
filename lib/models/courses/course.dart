import 'dart:convert';

class Course {
  int? id;
  String? location;
  String? title;
  String? start;
  String? end;
  String? status;
  String? description;

  Course({
    this.id,
    this.location,
    this.title,
    this.start,
    this.end,
    this.status,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location': location,
      'title': title,
      'start': start,
      'end': end,
      'status': status,
      'description': description,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      location: map['location'] ?? "",
      title: map['title'] ?? "",
      start: map['start'] ?? "",
      end: map['end'] ?? "",
      status: map['status'] ?? "",
      description: map['description'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));
}
