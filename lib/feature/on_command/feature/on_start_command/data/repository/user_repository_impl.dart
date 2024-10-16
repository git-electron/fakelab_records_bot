import 'package:injectable/injectable.dart';

import 'user_repository.dart';
import 'package:logger/logger.dart';
import '../../domain/model/user_model.dart';
import 'package:firebase_dart/database.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final Logger logger;
  final FirebaseDatabase database;

  UserRepositoryImpl({
    required this.logger,
    required this.database,
  });

  @override
  Future<User?> getUser(String userId) async {
    return null;
  }
}
