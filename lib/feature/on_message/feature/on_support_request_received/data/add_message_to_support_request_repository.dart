import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';

abstract class AddMessageToSupportRequestRepository {
  Future<SupportRequest?> call(int chatId, {required String message});
}
