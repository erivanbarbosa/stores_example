import 'dart:convert';

import 'package:redesprou_boilerplate_name/utils/string_utils.dart';

class Contact {
  int? id;
  String? name;
  String? birthDate;
  String? phone;
  String? email;
  String? details;

  Contact({
    this.id,
    this.name,
    this.birthDate,
    this.phone,
    this.email,
    this.details,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birthDate': birthDate,
      'phone': phone,
      'email': email,
      'details': details,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'] ?? "",
      birthDate: map['birthDate'] ?? "",
      phone: map['phone'] ?? "",
      email: map['email'] ?? "",
      details: map['details'] ?? "",
    );
  }

  bool isValid() {
    return isNotBlank(this.name) && isNotBlank(this.birthDate) && isNotBlank(this.phone) && isNotBlank(this.email);
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) => Contact.fromMap(json.decode(source));
}
