import '../../../../../../core/domain/model/support_request_model.dart';

abstract class AddMessageToSupportRequestRepository {
  Future<SupportRequest?> call(int chatId, {required String message});
}
