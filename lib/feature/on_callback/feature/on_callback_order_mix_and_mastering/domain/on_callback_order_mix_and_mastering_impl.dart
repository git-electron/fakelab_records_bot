import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../../../../../core/i18n/app_localization.g.dart';
import '../../../domain/models/order_mix_and_mastering_markup.dart';
import 'on_callback_order_mix_and_mastering.dart';

@Singleton(as: OnCallbackOrderMixAndMastering)
class OnCallbackOrderMixAndMasteringImpl
    implements OnCallbackOrderMixAndMastering {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final OrderMixAndMasteringMarkup orderMixAndMasteringMarkup;

  OnCallbackOrderMixAndMasteringImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.orderMixAndMasteringMarkup,
  });

  @override
  void call(TeleDartCallbackQuery callback) {
    final Message? message = callback.message;

    if (message == null) return;

    final Chat chat = message.chat;

    teledart.answerCallbackQuery(callback.id);
    teledart.editMessageText(
      translations.texts.order_mix_and_mastering_text,
      chatId: chat.id,
      messageId: message.messageId,
      parseMode: 'HTML',
      replyMarkup: orderMixAndMasteringMarkup(),
    );
  }
}
