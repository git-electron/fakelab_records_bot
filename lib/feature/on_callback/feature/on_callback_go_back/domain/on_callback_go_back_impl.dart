import 'package:fakelab_records_bot/feature/on_callback/domain/models/main_menu_markup.dart';
import 'package:fakelab_records_bot/feature/on_callback/domain/models/order_markup.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_go_back/domain/on_callback_go_back.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnCallbackGoBack)
class OnCallbackGoBackImpl implements OnCallbackGoBack {
  final Logger logger;
  final TeleDart teledart;
  final OrderMarkup orderMarkup;
  final MainMenuMarkup mainMenuMarkup;

  OnCallbackGoBackImpl({
    required this.logger,
    required this.teledart,
    required this.orderMarkup,
    required this.mainMenuMarkup,
  });

  @override
  void call(TeleDartCallbackQuery callback) {
    final Message? message = callback.message;
    final String? to = callback.data?.split('?to=').last;

    if (message == null || to == null) return;

    final Chat chat = message.chat;

    teledart.answerCallbackQuery(callback.id);
    teledart.editMessageReplyMarkup(
      chatId: chat.id,
      messageId: message.messageId,
      replyMarkup: _replyMarkup(to),
    );
  }

  InlineKeyboardMarkup _replyMarkup(String to) {
    switch (to) {
      case 'main_menu':
        return mainMenuMarkup();
      case 'order':
        return orderMarkup();
      default:
        return mainMenuMarkup();
    }
  }
}
