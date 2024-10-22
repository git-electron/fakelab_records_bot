import 'support_request_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_request_model.freezed.dart';
part 'support_request_model.g.dart';

@freezed
class SupportRequest with _$SupportRequest {

  factory SupportRequest({
    required int chatId,
    required DateTime dateCreated,
    required SupportRequestStatus status,
    String? message,
    int? adminId,
    String? adminUsername,
  }) = _SupportRequest;

  factory SupportRequest.fromJson(Map<String, dynamic> json) => _$SupportRequestFromJson(json);
}