abstract class ChatsService {
  Set<int> get chatsIds;

  void listenToChatIds();

  Future<void> addChat(int chatId);
}
