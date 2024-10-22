import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';
import 'package:fakelab_records_bot/core/domain/service/support_service.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_call_support/data/create_support_request_repository.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_call_support/domain/service/create_suport_request_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Singleton(as: CreateSupportRequestService)
class CreateSuportRequestServiceImpl implements CreateSupportRequestService {
  final Logger logger;
  final SupportService supportService;
  final CreateSupportRequestRepository createSupportRequestRepository;

  CreateSuportRequestServiceImpl({
    required this.logger,
    required this.supportService,
    required this.createSupportRequestRepository,
  });

  @override
  Future<SupportRequest?> call(int chatId) async {
    try {
      final DateTime now = DateTime.now();
      final SupportRequest supportRequest = SupportRequest(
        chatId: chatId,
        dateCreated: now,
        message: null,
      );

      final bool hasUserSupportRequest = supportService.supportRequests
          .where((SupportRequest request) => request.chatId == chatId)
          .isNotEmpty;

      if (hasUserSupportRequest) {
        return null;
      }

      return await createSupportRequestRepository(supportRequest);
    } catch (error) {
      logger.e('Failed to create order', error: error);
      return null;
    }
  }
}
