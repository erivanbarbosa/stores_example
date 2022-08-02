import 'dart:convert';

class CustomPage<T> {
  List<T>? items;
  int? page;
  int? last_page;
  int? per_page;
  int? total;

  CustomPage({
    this.items,
    this.page,
    this.last_page,
    this.per_page,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'last_page': last_page,
      'per_page': per_page,
      'total': total,
    };
  }

  factory CustomPage.fromMap(Map<String, dynamic> map) {
    return CustomPage<T>(
      page: map['page'],
      last_page: map['last_page'],
      per_page: map['per_page'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomPage.fromJson(String source) {
    return CustomPage.fromMap(json.decode(source));
  }

  Map<String, dynamic> toRequestMap() {
    return {
      'page': page,
    };
  }

  String joinUrlParams() {
    Map<String, dynamic> serviceMap = toRequestMap();
    serviceMap.removeWhere((key, value) => value == null);
    String result = serviceMap.map((key, value) => MapEntry(key, '&$key=$value')).values.fold<String>('?', (prev, elem) => '$prev$elem').replaceAll('?&', '?');
    if (result != null && result == "?")
      return "";
    else
      return result;
  }
}
