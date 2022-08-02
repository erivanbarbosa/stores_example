import 'package:intl/intl.dart';

String getYear(String? date) {
  String result = "";
  if (date != null && date.isNotEmpty && date.length > 3) {
    result = date.substring(0, 4);
  }
  return result;
}

DateTime? fromStringToDate(String? date) {
  DateTime? result;
  if (date != null && date.isNotEmpty && date.length > 3) {
    result = DateTime.parse(date);
  }
  return result;
}

DateTime? fromMMYYYYStringToDate(String? date) {
  DateTime? result;
  if (date != null && date.isNotEmpty && date.length > 3) {
    List<String> parts = date.split("/");

    result = DateTime.parse("${parts[1]}-${parts[0]}-01");
  }
  return result;
}

String fromDateTimeToYYYYMMDD(DateTime date) {
  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  return formattedDate;
}

String fomDateTimeToMMYYYY(DateTime date) {
  String formattedDate = DateFormat('MM/yyyy').format(date);
  return formattedDate;
}
