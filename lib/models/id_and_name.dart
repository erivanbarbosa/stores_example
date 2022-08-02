import 'dart:convert';

class IdAndName {
  int? id;
  String? name;

  IdAndName({
    this.id,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory IdAndName.fromMap(Map<String, dynamic> map) {
    return IdAndName(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory IdAndName.fromJson(String source) => IdAndName.fromMap(json.decode(source));
}
