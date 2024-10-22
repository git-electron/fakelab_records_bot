import '../../../../core/domain/model/user_model.dart';

abstract class GetUserRepository {
  Future<User?> call(int userId);
}
