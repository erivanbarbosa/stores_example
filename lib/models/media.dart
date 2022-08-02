import 'dart:convert';

class Media {
  int? id;
  String? url;

  Media({
    this.id,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
    };
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      id: map['id'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Media.fromJson(String source) => Media.fromMap(json.decode(source));
}
