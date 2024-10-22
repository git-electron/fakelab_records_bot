import 'package:fakelab_records_bot/feature/on_command/feature/on_support_request_complete_command/data/repository/delete_support_request_repository.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Singleton(as: DeleteSupportRequestRepository)
class DeleteSupportRequestRepositoryImpl
    implements DeleteSupportRequestRepository {
  final Logger logger;
  final DatabaseReference reference;

  DeleteSupportRequestRepositoryImpl({
    required this.logger,
    required this.reference,
  });

  @override
  Future<void> call(int chatId) async {
    try {
      final String path = 'support_requests/$chatId';

      logger.i('''Realtime Database deletion request:
Path: $path''');

      return await reference.child(path).remove();
    } catch (error) {
      logger.e('Failed to get user', error: error);
      return;
    }
  }
}
