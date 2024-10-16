import '../../domain/model/user_model.dart';

abstract class UserRepository {
  Future<User?> getUser(String userId);
}
