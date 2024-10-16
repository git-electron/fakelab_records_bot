import '../../../../../../core/domain/model/user_model.dart';

abstract class CreateUserRepository {
  Future<bool> call(User user);
}
