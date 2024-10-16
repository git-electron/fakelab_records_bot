import 'package:firebase_dart/database.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../../../core/domain/model/user_model.dart';
import 'get_user_repository.dart';

@Singleton(as: GetUserRepository)
class GetUserRepositoryImpl implements GetUserRepository {
  final Logger logger;
  final DatabaseReference reference;

  GetUserRepositoryImpl({
    required this.logger,
    required this.reference,
  });

  @override
  Future<User?> call(int userId) async {
    final String path = 'users/$userId';
    final Map<String, dynamic>? data = await reference.child(path).get();

    logger.i('''Realtime Database request:
Path: $path
Data: $data''');

    if (data == null) return null;

    final User user = User.fromJson(data);
    return user;
  }
}
