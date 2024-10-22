import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';
import 'package:fakelab_records_bot/core/domain/service/support_service.dart';
import 'package:fakelab_records_bot/feature/on_message/feature/on_support_request_received/data/add_message_to_support_request_repository.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Singleton(as: AddMessageToSupportRequestRepository)
class AddMessageToSupportRequestRepositoryImpl
    implements AddMessageToSupportRequestRepository {
  final Logger logger;
  final DatabaseReference reference;
  final SupportService supportService;

  AddMessageToSupportRequestRepositoryImpl({
    required this.logger,
    required this.reference,
    required this.supportService,
  });

  @override
  Future<SupportRequest?> call(int chatId, {required String message}) async {
    try {
      final List<SupportRequest> requests = supportService.supportRequests;
      final SupportRequest request = requests
          .where((SupportRequest request) => request.chatId == chatId)
          .first;
      final SupportRequest requestWithMessage =
          request.copyWith(message: message);

      final String path = 'support_requests/$chatId';
      final Map<String, dynamic> data = requestWithMessage.toJson();
      await reference.child(path).set(data);

      logger.i('''Realtime Database creation request:
Path: $path
Data: $data''');
      return requestWithMessage;
    } catch (error) {
      logger.e('Failed to get user orders', error: error);
      return null;
    }
  }
}
