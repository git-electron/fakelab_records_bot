import '../../../../../../core/domain/model/support_request_model.dart';
import '../../../../../../core/domain/model/support_request_status.dart';
import '../../../../../../core/domain/service/support_service.dart';
import '../../data/repository/change_support_request_status_repository.dart';
import 'set_support_request_in_progress_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Singleton(as: SetSupportRequestInProgressService)
class SetSupportRequestInProgressServiceImpl
    implements SetSupportRequestInProgressService {
  final Logger logger;
  final SupportService supportService;
  final ChangeSupportRequestStatusRepository
      changeSupportRequestStatusRepository;

  SetSupportRequestInProgressServiceImpl({
    required this.logger,
    required this.supportService,
    required this.changeSupportRequestStatusRepository,
  });

  @override
  Future<SupportRequest?> call(
    int chatId, {
    required int adminId,
    required String? adminUsername,
  }) async {
    try {
      final bool isThereAnotherInProgressRequest = supportService
          .supportRequests
          .where((SupportRequest request) =>
              request.status != SupportRequestStatus.REQUEST)
          .isNotEmpty;

      if (isThereAnotherInProgressRequest) return null;

      return await changeSupportRequestStatusRepository(
        chatId,
        adminId: adminId,
        adminUsername: adminUsername,
        status: SupportRequestStatus.IN_PROGRESS,
      );
    } catch (error) {
      logger.e('Failed to set support request in progress', error: error);
      return null;
    }
  }
}
