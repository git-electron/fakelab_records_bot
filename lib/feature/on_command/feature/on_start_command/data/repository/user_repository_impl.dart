import 'package:firebase_dart/database.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../domain/model/user_model.dart';
import 'user_repository.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final Logger logger;
  final FirebaseDatabase database;

  UserRepositoryImpl({
    required this.logger,
    required this.database,
  });

  @override
  Future<User?> getUser(int userId) async {
    final String path = 'users/$userId';
    final Map<String, dynamic>? userJson =
        await database.reference().child(path).get();

    logger.i('message');

    if (userJson == null) return null;

    final User user = User.fromJson(userJson);
    return user;
  }
}
