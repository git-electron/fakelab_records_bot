import 'package:firebase_dart/firebase_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../../../core/domain/model/support_request_model.dart';
import '../../../../../../core/domain/model/support_request_status.dart';
import '../../../../../../core/domain/service/support_service.dart';
import 'change_support_request_status_repository.dart';

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
    required int adminId,
    required String? adminUsername,
    required SupportRequestStatus status,
  }) async {
    try {
      final List<SupportRequest> requests = supportService.supportRequests;
      final SupportRequest request = requests
          .where((SupportRequest request) => request.chatId == chatId)
          .first;
      final SupportRequest requestWithStatus = request.copyWith(
        status: status,
        adminId: adminId,
        adminUsername: adminUsername,
      );

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
