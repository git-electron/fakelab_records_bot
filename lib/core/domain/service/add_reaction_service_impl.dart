import 'package:fakelab_records_bot/core/data/repository/add_reaction_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'add_reaction_service.dart';

@Singleton(as: AddReactionService)
class AddReactionServiceImpl implements AddReactionService {
  final Logger logger;
  final AddReactionRepository addReactionRepository;

  AddReactionServiceImpl({
    required this.logger,
    required this.addReactionRepository,
  });

  @override
  Future<bool> call(
    dynamic chatId, {
    required int messageId,
    String? reaction,
    bool? isBig,
  }) async {
    try {
      return addReactionRepository(
        chatId,
        messageId: messageId,
        reaction: reaction,
        isBig: isBig,
      );
    } catch (error) {
      logger.e(error);
      return false;
    }
  }
}
