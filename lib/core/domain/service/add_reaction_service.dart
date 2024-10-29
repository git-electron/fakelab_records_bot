abstract class AddReactionService {
  Future<bool> call(
    dynamic chatId, {
    required int messageId,
    String? reaction,
    bool? isBig,
  });
}
