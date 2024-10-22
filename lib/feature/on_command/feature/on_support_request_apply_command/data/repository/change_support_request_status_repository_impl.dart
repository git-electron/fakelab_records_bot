import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';
import 'package:fakelab_records_bot/core/domain/model/support_request_status.dart';
import 'package:fakelab_records_bot/core/domain/service/support_service.dart';
import 'package:fakelab_records_bot/feature/on_command/feature/on_support_request_apply_command/data/repository/change_support_request_status_repository.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Singleton(as: ChangeSupportRequestStatusRepository)
class ChangeSupportRequestStatusRepositoryImpl
    implements ChangeSupportRequestStatusRepository {
  final Logger logger;
  final DatabaseReference reference;
  final SupportService supportService;

  ChangeSupportRequestStatusRepositoryImpl({
    required this.logger,
    required this.reference,
    required this.supportService,
  });

  @override
  Future<SupportRequest?> call(
    int chatId, {
    required SupportRequestStatus status,
  }) async {
    try {
      final List<SupportRequest> requests = supportService.supportRequests;
      final SupportRequest request = requests
          .where((SupportRequest request) => request.chatId == chatId)
          .first;
      final SupportRequest requestWithStatus = request.copyWith(status: status);

      final String path = 'support_requests/$chatId';
      final Map<String, dynamic> data = requestWithStatus.toJson();
      await reference.child(path).set(data);

      logger.i('''Realtime Database creation request:
Path: $path
Data: $data''');
      return requestWithStatus;
    } catch (error) {
      logger.e('Failed to get user orders', error: error);
      return null;
    }
  }
}
