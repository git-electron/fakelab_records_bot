import 'package:fakelab_records_bot/core/domain/service/chats_service.dart';
import 'package:firebase_dart/database.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Singleton(as: ChatsService)
class ChatsServiceImpl implements ChatsService {
  final Logger logger;
  final DatabaseReference reference;

  ChatsServiceImpl({
    required this.logger,
    required this.reference,
  });

  Set<int> _chatsIds = {};
  final String _path = 'chats';

  @override
  Set<int> get chatsIds => _chatsIds;

  @PostConstruct()
  @override
  void listenToChatIds() async {
    try {
      reference.child(_path).onValue.listen((Event event) {
        final DataSnapshot snapshot = event.snapshot;
        final List<dynamic>? data = snapshot.value;

        logger.i('''Realtime Database event from stream:
Path: $_path
Data: $data''');

        if (data == null) {
          _chatsIds = {};
          return;
        }

        _chatsIds = data.toSet().cast<int>();
      }).onError(throw Exception());
    } catch (error) {
      logger.e('Failed to get chats', error: error);
    }
  }

  @override
  Future<void> addChat(int chatId) async {
    try {
      await reference.child(_path).set([..._chatsIds, chatId]);
    } catch (error) {
      logger.e(error);
    }
  }
}
