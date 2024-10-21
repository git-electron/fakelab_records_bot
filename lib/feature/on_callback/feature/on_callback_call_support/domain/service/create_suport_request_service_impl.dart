import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_call_support/data/create_support_request_repository.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_call_support/data/get_user_support_requests_repository.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_call_support/domain/service/create_suport_request_service.dart';
import 'package:logger/logger.dart';

class CreateSuportRequestServiceImpl implements CreateSuportRequestService {
  final Logger logger;
  final CreateSupportRequestRepository createSupportRequestRepository;
  final GetUserSupportRequestsRepository getUserSupportRequestsRepository;

  CreateSuportRequestServiceImpl({
    required this.logger,
    required this.createSupportRequestRepository,
    required this.getUserSupportRequestsRepository,
  });

  @override
  Future<SupportRequest?> call(int userId) async {
    try {
      final SupportRequest supportRequest = SupportRequest(
        chatId: userId,
        message: null,
      );

      final SupportRequest? userSupportRequest =
          await getUserSupportRequestsRepository(userId);

      if (userSupportRequest != null) {
        return null;
      }

      return await createSupportRequestRepository(supportRequest);
    } catch (error) {
      logger.e('Failed to create order', error: error);
      return null;
    }
  }
}
