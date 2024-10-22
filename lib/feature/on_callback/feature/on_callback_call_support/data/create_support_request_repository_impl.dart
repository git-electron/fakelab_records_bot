import '../../../../../core/domain/model/support_request_model.dart';
import 'create_support_request_repository.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Singleton(as: CreateSupportRequestRepository)
class CreateSupportRequestRepositoryImpl
    implements CreateSupportRequestRepository {
  final Logger logger;
  final DatabaseReference reference;

  CreateSupportRequestRepositoryImpl({
    required this.logger,
    required this.reference,
  });

  @override
  Future<SupportRequest?> call(SupportRequest request) async {
    try {
      final String path = 'support_requests/${request.chatId}';
      final Map<String, dynamic> data = request.toJson();
      await reference.child(path).set(data);

      logger.i('''Realtime Database creation request:
Path: $path
Data: $data''');
      return request;
    } catch (error) {
      logger.e('Failed to get user orders', error: error);
      return null;
    }
  }
}
