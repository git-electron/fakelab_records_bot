import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';
import 'package:fakelab_records_bot/core/domain/model/support_request_status.dart';

abstract class ChangeSupportRequestStatusRepository {
  Future<SupportRequest?> call(
    int chatId, {
    required int adminId,
    required String? adminUsername,
    required SupportRequestStatus status,
  });
}
