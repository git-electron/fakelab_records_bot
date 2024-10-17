import 'dart:async';

import '../../../../../../../core/domain/service/id_service.dart';
import '../../../../../../../core/i18n/app_localization.g.dart';
import 'on_confirm_order_mix.dart';
import '../../../../on_callback_main_menu/domain/on_callback_main_menu.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnConfirmOrderMix)
class OnConfirmOrderMixImpl implements OnConfirmOrderMix {
  final Logger logger;
  final TeleDart teledart;
  final IdService idService;
  final Translations translations;
  final OnCallbackMainMenu onCallbackMainMenu;

  OnConfirmOrderMixImpl({
    required this.logger,
    required this.teledart,
    required this.idService,
    required this.translations,
    required this.onCallbackMainMenu,
  });

  @override
  void call(TeleDartCallbackQuery callback) {
    final Message? message = callback.message;

    if (message == null) return;

    final Chat chat = message.chat;

    teledart.answerCallbackQuery(callback.id);

    teledart.editMessageText(
      translations.texts.mix_ordered_text(
        order: translations.cards.order(
          orderId: '00000',
          orderType: 'Тестовый',
          status: '🟡 Тестовый',
          dayCreated: '00',
          monthCreated: 'октября',
          yearCreated: '0000',
          totalCost: 'от 0,000',
        ),
        secondsLeft: 5,
        secondsLeftPlural: translations.plurals.seconds_left(n: 5),
      ),
      chatId: chat.id,
      messageId: message.messageId,
      parseMode: 'HTML',
    );

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      final int secondsLeft = 5 - timer.tick;

      teledart.editMessageText(
        translations.texts.mix_ordered_text(
          order: translations.cards.order(
            orderId: '00000',
            orderType: 'Тестовый',
            status: '🟡 Тестовый',
            dayCreated: '00',
            monthCreated: 'октября',
            yearCreated: '0000',
            totalCost: 'от 0,000',
          ),
          secondsLeft: secondsLeft,
          secondsLeftPlural: translations.plurals.seconds_left(n: secondsLeft),
        ),
        chatId: chat.id,
        messageId: message.messageId,
        parseMode: 'HTML',
      );

      if (secondsLeft <= 0) {
        timer.cancel();
        await Future.delayed(const Duration(seconds: 1));
        onCallbackMainMenu(callback);
      }
    });
  }
}
