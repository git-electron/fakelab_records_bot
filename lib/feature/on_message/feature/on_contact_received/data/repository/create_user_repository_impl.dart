import 'package:fakelab_records_bot/feature/on_message/feature/on_contact_received/data/repository/create_user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../../../core/domain/model/user_model.dart';

@Singleton(as: CreateUserRepository)
class CreateUserRepositoryImpl implements CreateUserRepository {
  final Logger logger;

  CreateUserRepositoryImpl({
    required this.logger,
  });

  @override
  Future<bool> call(User user) async {
    return false;
  }
}
