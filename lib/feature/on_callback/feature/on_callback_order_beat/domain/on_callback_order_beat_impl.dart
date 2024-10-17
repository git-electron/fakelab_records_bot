import '../../../../../core/i18n/app_localization.g.dart';
import '../../../domain/models/order_beat_markup.dart';
import 'on_callback_order_beat.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnCallbackOrderBeat)
class OnCallbackOrderBeatImpl implements OnCallbackOrderBeat {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final OrderBeatMarkup orderBeatMarkup;

  OnCallbackOrderBeatImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.orderBeatMarkup,
  });

  @override
  void call(TeleDartCallbackQuery callback) {
    final Message? message = callback.message;

    if (message == null) return;

    final Chat chat = message.chat;

    teledart.answerCallbackQuery(callback.id);
    teledart.editMessageText(
      translations.texts.order_beat_text,
      chatId: chat.id,
      messageId: message.messageId,
      parseMode: 'HTML',
      replyMarkup: orderBeatMarkup(),
    );
  }
}