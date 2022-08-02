import 'dart:convert';

import 'package:redesprou_boilerplate_name/models/courses/course.dart';
import 'package:redesprou_boilerplate_name/models/services/service.dart';

class Profile {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? cpf;
  String? address_1;
  String? address_2;
  String? zipcode;
  String? occupation;
  String? education;
  String? education_location;
  String? education_start;
  String? education_end;
  String? education_status;
  String? education_description;
  String? bio;
  String? genre;
  String? birthdate;
  String? facebook_url;
  String? instagram_url;
  int? city_id;
  int? state_id;
  String? profile_photo_path;
  String? featured_photo_path;
  List<Course>? courses;
  List<Service>? services;

  Profile(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.cpf,
      this.address_1,
      this.address_2,
      this.zipcode,
      this.occupation,
      this.education,
      this.education_location,
      this.education_start,
      this.education_end,
      this.education_status,
      this.education_description,
      this.bio,
      this.genre,
      this.birthdate,
      this.facebook_url,
      this.instagram_url,
      this.city_id,
      this.state_id,
      this.profile_photo_path,
      this.featured_photo_path,
      this.courses,
      this.services});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'cpf': cpf,
      'address_1': address_1,
      'address_2': address_2,
      'zipcode': zipcode,
      'occupation': occupation,
      'education': education,
      'education_location': education_location,
      'education_start': education_start,
      'education_end': education_end,
      'education_status': education_status,
      'education_description': education_description,
      'city_id': city_id,
      'state_id': state_id,
      'bio': bio,
      'genre': genre,
      'birthdate': birthdate,
      'facebook_url': facebook_url,
      'instagram_url': instagram_url,
      'profile_photo_path': profile_photo_path,
      'featured_photo_path': featured_photo_path,
      'courses': courses?.map((x) => x.toMap()).toList(),
      'services': services?.map((x) => x.toMap()).toList()
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
        id: map['id'] ?? "",
        name: map['name'] ?? "",
        email: map['email'] ?? "",
        phone: map['phone'] ?? "",
        cpf: map['cpf'] ?? "",
        address_1: map['address_1'] ?? "",
        address_2: map['address_2'] ?? "",
        zipcode: map['zipcode'] ?? "",
        occupation: map['occupation'] ?? "",
        education: map['education'] ?? "",
        education_location: map['education_location'] ?? "",
        education_start: map['education_start'] ?? "",
        education_end: map['education_end'] ?? "",
        education_status: map['education_status'] ?? "",
        education_description: map['education_description'] ?? "",
        city_id: map['city_id'] ?? null,
        state_id: map['state_id'] ?? null,
        bio: map['bio'] ?? "",
        genre: map['genre'] ?? "",
        birthdate: map['birthdate'] ?? "",
        facebook_url: map['facebook_url'] ?? "",
        instagram_url: map['instagram_url'] ?? "",
        profile_photo_path: map['profile_photo_path'] ?? "",
        featured_photo_path: map['featured_photo_path'] ?? "",
        courses: List<Course>.from(map['courses']?.map((x) => Course.fromMap(x))),
        services: List<Service>.from(map['services']?.map((x) => Service.fromMap(x))));
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) => Profile.fromMap(json.decode(source));
}
