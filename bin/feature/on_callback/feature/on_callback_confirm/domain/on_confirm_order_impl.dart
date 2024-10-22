import 'dart:async';

import 'package:injectable/injectable.dart' hide Order;
import 'package:logger/logger.dart';
import 'package:teledart/model.dart' hide User;
import 'package:teledart/teledart.dart';

import '../../../../../core/domain/service/id_service.dart';
import '../../../../../core/i18n/app_localization.g.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/extensions/date_time_extensions.dart';
import '../../../../../core/extensions/double_extensions.dart';
import '../../on_callback_main_menu/domain/on_callback_main_menu.dart';
import 'models/order_model.dart';
import 'models/order_type.dart';
import 'on_confirm_order.dart';
import 'service/create_order_service.dart';

@Injectable(as: OnConfirmOrder)
class OnConfirmOrderImpl implements OnConfirmOrder {
  final Logger logger;
  final TeleDart teledart;
  final IdService idService;
  final Translations translations;
  final OnCallbackMainMenu onCallbackMainMenu;
  final CreateOrderService createOrderService;

  OnConfirmOrderImpl({
    required this.logger,
    required this.teledart,
    required this.idService,
    required this.translations,
    required this.onCallbackMainMenu,
    required this.createOrderService,
  });

  static const int initialSeconds = 10;

  @override
  void call(
    TeleDartCallbackQuery callback, {
    required OrderType orderType,
  }) async {
    try {
      final Message? message = callback.message;

      if (message == null) return;

      final Chat chat = message.chat;

      final Order? order = await createOrderService(
        callback.from.id,
        orderType: orderType,
      );

      if (order == null) {
        await teledart.editMessageText(
          translations.texts.order_already_exists_text(
            secondsLeft: initialSeconds,
            secondsLeftPlural:
                translations.plurals.seconds_left(n: initialSeconds),
          ),
          chatId: chat.id,
          messageId: message.messageId,
          parseMode: Constants.parseMode,
        );

        Timer.periodic(const Duration(seconds: 1), (timer) async {
          final int secondsLeft = initialSeconds - timer.tick;

          await teledart.editMessageText(
            translations.texts.order_already_exists_text(
              secondsLeft: secondsLeft,
              secondsLeftPlural:
                  translations.plurals.seconds_left(n: secondsLeft),
            ),
            chatId: chat.id,
            messageId: message.messageId,
            parseMode: Constants.parseMode,
          );

          if (secondsLeft <= 0) {
            timer.cancel();
            await Future.delayed(const Duration(seconds: 1));
            onCallbackMainMenu(callback);
          }
        });
      } else {
        await teledart.editMessageText(
          _orderCreatedText(order, initialSeconds),
          chatId: chat.id,
          messageId: message.messageId,
          parseMode: Constants.parseMode,
        );

        Timer.periodic(const Duration(seconds: 1), (timer) async {
          final int secondsLeft = initialSeconds - timer.tick;

          await teledart.editMessageText(
            _orderCreatedText(order, secondsLeft),
            chatId: chat.id,
            messageId: message.messageId,
            parseMode: Constants.parseMode,
          );

          if (secondsLeft <= 0) {
            timer.cancel();
            await Future.delayed(const Duration(seconds: 1));
            onCallbackMainMenu(callback);
          }
        });
      }
      await teledart.answerCallbackQuery(callback.id);
    } catch (error) {
      logger.e(error);
    }
  }

  String _orderCreatedText(Order order, int secondsLeft) {
    final String totalCost = order.costFrom
        ? translations.cards.order
            .total_cost_from(totalCost: order.totalCost.inCurrencyRounded)
        : order.totalCost.inCurrencyRounded;

    return translations.texts.order_created_text(
      order: translations.cards.order.card(
        orderId: order.id.substring(order.id.length - 5),
        orderType: translations.cards.order.type.mix,
        status: translations.cards.order.status.request,
        dateCreated: order.dateCreated.dateFormatted,
        totalCost: totalCost,
      ),
      secondsLeft: secondsLeft,
      secondsLeftPlural: translations.plurals.seconds_left(n: secondsLeft),
    );
  }
}
