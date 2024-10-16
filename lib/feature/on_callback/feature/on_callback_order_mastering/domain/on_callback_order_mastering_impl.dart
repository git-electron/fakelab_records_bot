import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:fakelab_records_bot/feature/on_callback/domain/models/order_mastering_markup.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_order_mastering/domain/on_callback_order_mastering.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnCallbackOrderMastering)
class OnCallbackOrderMasteringImpl implements OnCallbackOrderMastering {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final OrderMasteringMarkup orderMasteringMarkup;

  OnCallbackOrderMasteringImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.orderMasteringMarkup,
  });

  @override
  void call(TeleDartCallbackQuery callback) {
    final Message? message = callback.message;

    if (message == null) return;

    final Chat chat = message.chat;

    teledart.answerCallbackQuery(callback.id);
    teledart.editMessageText(
      translations.texts.order_mastering_text,
      chatId: chat.id,
      messageId: message.messageId,
      parseMode: 'Markdown',
      replyMarkup: orderMasteringMarkup(),
    );
  }
}
