import 'package:injectable/injectable.dart' hide Order;
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/extensions/date_time_extensions.dart';
import '../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../core/i18n/app_localization.g.dart';
import '../../../../on_callback/domain/models/my_orders_markup.dart';
import '../../../../on_callback/feature/on_callback_confirm/domain/models/order_model.dart';
import '../../../../on_callback/feature/on_callback_confirm/domain/models/order_status.dart';
import '../../../../on_callback/feature/on_callback_confirm/domain/models/order_type.dart';
import '../../../../on_callback/feature/on_callback_my_orders/domain/service/get_user_orders_service.dart';
import 'on_orders_command.dart';

@Singleton(as: OnOrdersCommand)
class OnOrdersCommandImpl implements OnOrdersCommand {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final MyOrdersMarkup myOrdersMarkup;
  final GetUserOrdersService getUserOrdersService;

  OnOrdersCommandImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.myOrdersMarkup,
    required this.getUserOrdersService,
  });

  @override
  void call(TeleDartMessage message) async {
    try {
      if (message.from == null) return;

      final List<Order>? orders = await getUserOrdersService(
        message.from!.id,
        showMore: false,
      );

      if (orders == null) {
        await teledart.sendMessage(
          message.chat.id,
          translations.texts.my_orders_text(
            orders: translations.errors.orders_empty,
          ),
          parseMode: Constants.parseMode,
          disableWebPagePreview: true,
          replyMarkup: myOrdersMarkup(showMoreButton: false),
        );
        return;
      }

      await teledart.sendMessage(
        message.chat.id,
        translations.texts.my_orders_text(
          orders: _orders(orders),
        ),
        parseMode: Constants.parseMode,
        disableWebPagePreview: true,
        replyMarkup: myOrdersMarkup(showMoreButton: true),
      );
    } catch (error) {
      logger.e(error);
    }
  }

  String _orders(List<Order> orders) {
    return orders.map((Order order) {
      return translations.cards.order.card(
        orderId: order.id.substring(order.id.length - 5),
        orderType: _orderType(order.type),
        status: _orderStatus(order.status),
        dateCreated: order.dateCreated.dateFormatted,
        totalCost: _totalCost(order.totalCost, costFrom: order.costFrom),
      );
    }).join('\n\n');
  }

  String _orderType(OrderType orderType) {
    return switch (orderType) {
      OrderType.MIX => translations.cards.order.type.mix,
      OrderType.MASTERING => translations.cards.order.type.mastering,
      OrderType.MIX_AND_MASTERING =>
        translations.cards.order.type.mix_and_mastering,
      OrderType.BEAT => translations.cards.order.type.beat,
    };
  }

  String _orderStatus(OrderStatus orderStatus) {
    return switch (orderStatus) {
      OrderStatus.REQUEST => translations.cards.order.status.request,
      OrderStatus.PENDING => translations.cards.order.status.pending,
      OrderStatus.IN_PROGRESS => translations.cards.order.status.in_progress,
      OrderStatus.AWAITING_CONFIRMATION =>
        translations.cards.order.status.awaiting_confirmation,
      OrderStatus.COMPLETED => translations.cards.order.status.completed,
      OrderStatus.CANCELLED => translations.cards.order.status.cancelled,
    };
  }

  String _totalCost(double totalCost, {required bool costFrom}) {
    return costFrom
        ? translations.cards.order
            .total_cost_from(totalCost: totalCost.inCurrencyRounded)
        : totalCost.inCurrencyRounded;
  }
}
