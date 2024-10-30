import '../../../../../../../../../core/domain/model/support_request_model.dart';
import '../../../../../../../../../core/domain/model/support_request_status.dart';
import '../../../../../../../../../core/domain/service/support_service.dart';
import '../../data/create_support_request_repository.dart';
import 'create_suport_request_service.dart';
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
        status: SupportRequestStatus.REQUEST,
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
