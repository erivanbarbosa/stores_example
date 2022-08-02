import 'dart:convert';

import 'package:redesprou_boilerplate_name/models/id_and_name.dart';
import 'package:redesprou_boilerplate_name/models/media.dart';
import 'package:redesprou_boilerplate_name/models/services/service_user.dart';

class Service {
  int? id;
  String? title;
  String? description;
  List<int>? categories;
  List<IdAndName>? serviceCategories;
  bool? home_care;
  bool? own_address;
  String? address_1;
  String? address_2;
  String? zipcode;
  int? city_id;
  int? state_id;
  IdAndName? city;
  IdAndName? state;
  List<String>? days_of_week;
  bool? all_of_day;
  bool? attendance_on_morning;
  bool? attendance_on_afternoon;
  bool? attendance_on_night;
  String? service_guarantee;
  String? my_responsibility;
  String? customer_responsibility;
  List<Media>? medias;
  ServiceUser? user;

  Service({
    this.id,
    this.title,
    this.description,
    this.categories,
    this.serviceCategories,
    this.home_care,
    this.own_address,
    this.address_1,
    this.address_2,
    this.zipcode,
    this.city_id,
    this.city,
    this.state_id,
    this.state,
    this.days_of_week,
    this.all_of_day,
    this.attendance_on_morning,
    this.attendance_on_afternoon,
    this.attendance_on_night,
    this.service_guarantee,
    this.my_responsibility,
    this.customer_responsibility,
    this.medias,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'categories': categories,
      'home_care': home_care,
      'own_address': own_address,
      'address_1': address_1,
      'address_2': address_2,
      'zipcode': zipcode,
      'city_id': city_id,
      'state_id': state_id,
      'city': city != null ? city!.toMap() : null,
      'state': state != null ? state!.toMap() : null,
      'days_of_week': days_of_week,
      'all_of_day': all_of_day,
      'attendance_on_morning': attendance_on_morning,
      'attendance_on_afternoon': attendance_on_afternoon,
      'attendance_on_night': attendance_on_night,
      'service_guarantee': service_guarantee,
      'my_responsibility': my_responsibility,
      'customer_responsibility': customer_responsibility,
      'medias': medias?.map((x) => x.toMap()).toList()
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
        id: map['id'] ?? null,
        title: map['title'],
        description: map['description'],
        categories: List<int>.from(map['categories']?.map((x) => x['id'])),
        serviceCategories: List<IdAndName>.from(map['categories']?.map((x) => IdAndName.fromMap(x))),
        home_care: map['home_care'],
        own_address: map['own_address'],
        address_1: map['address_1'],
        address_2: map['address_2'],
        zipcode: map['zipcode'],
        city_id: map['city_id'],
        state_id: map['state_id'],
        city: map['city'] != null ? IdAndName.fromMap(map['city']) : null,
        state: map['city'] != null ? IdAndName.fromMap(map['state']) : null,
        days_of_week: map['days_of_week'] != null ? List<String>.from(map['days_of_week']) : null,
        all_of_day: map['all_of_day'],
        attendance_on_morning: map['attendance_on_morning'],
        attendance_on_afternoon: map['attendance_on_afternoon'],
        attendance_on_night: map['attendance_on_night'],
        service_guarantee: map['service_guarantee'],
        my_responsibility: map['my_responsibility'],
        customer_responsibility: map['customer_responsibility'],
        user: ServiceUser.fromMap(map['user']),
        medias: List<Media>.from(map['medias']?.map((x) => Media.fromMap(x))));
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) => Service.fromMap(json.decode(source));
}
