import 'dart:convert';

class ServiceUser {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? profile_photo_path;

  ServiceUser({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profile_photo_path,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_photo_path': profile_photo_path,
    };
  }

  factory ServiceUser.fromMap(Map<String, dynamic> map) {
    return ServiceUser(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      profile_photo_path: map['profile_photo_path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceUser.fromJson(String source) => ServiceUser.fromMap(json.decode(source));
}
