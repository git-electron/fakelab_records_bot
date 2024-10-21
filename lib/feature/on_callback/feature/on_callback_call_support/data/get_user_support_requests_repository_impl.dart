import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_call_support/data/get_user_support_requests_repository.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Singleton(as: GetUserSupportRequestsRepository)
class GetUserSupportRequestsRepositoryImpl
    implements GetUserSupportRequestsRepository {
  final Logger logger;
  final DatabaseReference reference;

  GetUserSupportRequestsRepositoryImpl({
    required this.logger,
    required this.reference,
  });

  @override
  Future<SupportRequest?> call(int userId) async {
    try {
      final String path = 'support_requests/$userId';
      final Map<String, dynamic>? data = await reference.child(path).get();

      logger.i('''Realtime Database request:
Path: $path
Data: $data''');

      if (data == null) return null;

      final SupportRequest request = SupportRequest.fromJson(data);
      return request;
    } catch (error) {
      logger.e('Failed to get user', error: error);
      return null;
    }
  }
}
