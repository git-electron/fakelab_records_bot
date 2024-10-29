import '../../../../../../../core/domain/model/support_request_model.dart';
import '../../../../../../../core/domain/model/support_request_status.dart';

abstract class ChangeSupportRequestStatusRepository {
  Future<SupportRequest?> call(
    int chatId, {
    required int adminId,
    required String? adminUsername,
    required SupportRequestStatus status,
  });
}
