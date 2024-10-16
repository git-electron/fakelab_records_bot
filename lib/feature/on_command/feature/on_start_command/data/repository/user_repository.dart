import 'package:fakelab_records_bot/feature/on_command/feature/on_start_command/domain/model/user_model.dart';

abstract class UserRepository {
  Future<User?> getUser(String userId);
}
