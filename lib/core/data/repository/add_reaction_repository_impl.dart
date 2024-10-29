import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/telegram.dart';

import 'add_reaction_repository.dart';
import '../client/reactions_client.dart';
import '../../constants/dotenv_constants.dart';

@Singleton(as: AddReactionRepository)
class AddReactionRepositoryImpl implements AddReactionRepository {
  final Logger logger;
  final ReactionsClient reactionsClient;

  final String _token;
  final String _baseUrl = 'api.telegram.org';

  AddReactionRepositoryImpl({
    required this.logger,
    required this.reactionsClient,
  }) : _token = DotEnvConstants.TELEGRAM_API_TOKEN;

  @override
  Future<bool> call(
    dynamic chatId, {
    required int messageId,
    String? reaction,
    bool? isBig,
  }) async {
    if (chatId is! String && chatId is! int) {
      return Future.error(TelegramException(
          'Attribute \'chatId\' can only be either type of String or int'));
    }
    var requestUrl = _apiUri('setMessageReaction');
    var body = <String, dynamic>{
      'chat_id': chatId,
      'message_id': messageId,
      'reaction': json.encode([
        <String, dynamic>{
          'type': 'emoji',
          'emoji': reaction,
        }
      ]),
      'isBig': isBig,
    };
    return await ReactionsClient.httpPost(requestUrl, body: body);
  }

  Uri _apiUri(String unencodedPath, [Map<String, dynamic>? queryParameters]) =>
      Uri.https(_baseUrl, 'bot$_token/$unencodedPath', queryParameters);
}
