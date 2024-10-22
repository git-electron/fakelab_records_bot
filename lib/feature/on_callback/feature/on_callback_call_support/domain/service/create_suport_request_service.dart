import '../../../../../../core/domain/model/support_request_model.dart';

abstract class CreateSupportRequestService {
  Future<SupportRequest?> call(int chatId);
}
