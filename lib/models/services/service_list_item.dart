import 'dart:convert';

class ServiceListItem {
  int? id;
  String? title;
  String? service_provider_name;
  String? service_provider_profile_photo_path;

  ServiceListItem({
    this.id,
    this.title,
    this.service_provider_name,
    this.service_provider_profile_photo_path,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'service_provider_name': service_provider_name,
      'service_provider_profile_photo_path': service_provider_profile_photo_path,
    };
  }

  factory ServiceListItem.fromMap(Map<String, dynamic> map) {
    return ServiceListItem(
      id: map['id'],
      title: map['title'],
      service_provider_name: map['service_provider_name'],
      service_provider_profile_photo_path: map['service_provider_profile_photo_path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceListItem.fromJson(String source) => ServiceListItem.fromMap(json.decode(source));
}
