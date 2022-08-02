import 'dart:convert';

class CreateProfile {
  final String name;
  final String email;
  final String password;
  final String password_confirmation;

  CreateProfile({
    required this.name,
    required this.email,
    required this.password,
    required this.password_confirmation,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
    };
  }

  factory CreateProfile.fromMap(Map<String, dynamic> map) {
    return CreateProfile(
      name: map['name'],
      email: map['email'],
      password: map['password'],
      password_confirmation: map['password_confirmation'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateProfile.fromJson(String source) => CreateProfile.fromMap(json.decode(source));
}
