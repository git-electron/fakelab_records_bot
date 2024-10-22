import '../../../../../../core/domain/model/user_model.dart';

abstract class CreateUserRepository {
  Future<void> call(int userId, {required User user});
}
