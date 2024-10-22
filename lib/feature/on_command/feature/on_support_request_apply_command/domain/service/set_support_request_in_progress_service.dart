import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';

abstract class SetSupportRequestInProgressService {
  Future<SupportRequest?> call(
    int chatId, {
    required int adminId,
    required String? adminUsername,
  });
}
