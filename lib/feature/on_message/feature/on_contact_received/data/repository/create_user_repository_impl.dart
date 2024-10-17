import 'create_user_repository.dart';
import 'package:firebase_dart/database.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../../../core/domain/model/user_model.dart';

@Singleton(as: CreateUserRepository)
class CreateUserRepositoryImpl implements CreateUserRepository {
  final Logger logger;
  final DatabaseReference reference;

  CreateUserRepositoryImpl({
    required this.logger,
    required this.reference,
  });

  @override
  Future<void> call(int userId, {required User user}) async {
    final String path = 'users/$userId';
    final Map<String, dynamic> data = user.toJson();
    await reference.child(path).set(data);

    logger.i('''Realtime Database creation request:
Path: $path
Data: $data''');
  }
}
