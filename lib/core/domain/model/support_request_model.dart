import 'package:fakelab_records_bot/core/converters/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'support_request_status.dart';

part 'support_request_model.freezed.dart';
part 'support_request_model.g.dart';

@freezed
class SupportRequest with _$SupportRequest {
  factory SupportRequest({
    required int chatId,
    @DateTimeConverter() required DateTime dateCreated,
    required SupportRequestStatus status,
    String? message,
    int? adminId,
    String? adminUsername,
  }) = _SupportRequest;

  factory SupportRequest.fromJson(Map<String, dynamic> json) =>
      _$SupportRequestFromJson(json);
}
