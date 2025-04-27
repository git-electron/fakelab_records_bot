import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    final DateTime data = DateTime.parse(json).toLocal();
    return data.add(-data.timeZoneOffset);
  }

  @override
  String toJson(DateTime data) => data.toUtc().toIso8601String();
}
