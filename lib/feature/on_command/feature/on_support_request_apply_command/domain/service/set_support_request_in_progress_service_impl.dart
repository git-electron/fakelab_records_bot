import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';
import 'package:fakelab_records_bot/core/domain/model/support_request_status.dart';
import 'package:fakelab_records_bot/core/domain/service/support_service.dart';
import 'package:fakelab_records_bot/feature/on_command/feature/on_support_request_apply_command/data/repository/change_support_request_status_repository.dart';
import 'package:fakelab_records_bot/feature/on_command/feature/on_support_request_apply_command/domain/service/set_support_request_in_progress_service.dart';
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
  Future<SupportRequest?> call(int chatId) async {
    try {
      final bool isThereAnotherInProgressRequest = supportService
          .supportRequests
          .where((SupportRequest request) =>
              request.status != SupportRequestStatus.REQUEST)
          .isNotEmpty;

      if (isThereAnotherInProgressRequest) return null;

      return await changeSupportRequestStatusRepository(
        chatId,
        status: SupportRequestStatus.IN_PROGRESS,
      );
    } catch (error) {
      logger.e('Failed to set support request in progress', error: error);
      return null;
    }
  }
}
