import 'dart:convert';

class ServiceFilter {
  String? s;
  List<int>? categories;

  ServiceFilter({
    this.s,
    this.categories,
  });

  Map<String, dynamic> toMap() {
    return {
      's': s,
      'categories': categories != null && categories!.isNotEmpty ? categories.toString().replaceAll(" ", "").replaceAll("[", "").replaceAll("]", "") : null,
    };
  }

  factory ServiceFilter.fromMap(Map<String, dynamic> map) {
    return ServiceFilter(
      s: map['s'],
      categories: List<int>.from(map['categories']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceFilter.fromJson(String source) => ServiceFilter.fromMap(json.decode(source));

  String joinUrlParams() {
    Map<String, dynamic> serviceMap = toMap();
    serviceMap.removeWhere((key, value) => value == null);

    String result = serviceMap.map((key, value) => MapEntry(key, '&$key=$value')).values.fold<String>('?', (prev, elem) => '$prev$elem').replaceAll('?&', '?');
    if (result != null && result == "?")
      return "";
    else
      return result;
  }
}
