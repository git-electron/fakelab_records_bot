import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  static const _kTimezoneOffsetDuration = Duration(hours: 3);

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime data) =>
      data.toUtc().add(_kTimezoneOffsetDuration).toIso8601String();
}
