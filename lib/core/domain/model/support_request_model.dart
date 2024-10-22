import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_request_model.freezed.dart';
part 'support_request_model.g.dart';

@freezed
class SupportRequest with _$SupportRequest {

  factory SupportRequest({
    required int chatId,
    required DateTime dateCreated,
    String? message,
  }) = _SupportRequest;

  factory SupportRequest.fromJson(Map<String, dynamic> json) => _$SupportRequestFromJson(json);
}