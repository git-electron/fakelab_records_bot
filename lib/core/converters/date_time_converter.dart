import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  static const _kTimezoneOffsetDuration = Duration(hours: 3);

  @override
  DateTime fromJson(String json) =>
      DateTime.parse(json).add(_kTimezoneOffsetDuration);

  @override
  String toJson(DateTime data) => data.toUtc().toIso8601String();
}
