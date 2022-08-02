isBlank(String? value) {
  bool result = value == null || value.isEmpty;
  return result;
}

isNotBlank(String? value) {
  bool result = !isBlank(value);
  return result;
}

isBlankList(List? list) {
  bool result = list == null || list.isEmpty;
  return result;
}

isNotBlankList(List? list) {
  bool result = !isBlankList(list);
  return result;
}

isTrue(bool? value) {
  return value != null && value == true;
}

isFalse(bool? value) {
  return value != null && value == false;
}
