import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/i18n/app_localization.g.dart';
import '../feature/on_callback_admin_access/domain/on_callback_admin_access.dart';
import '../feature/on_callback_support/feature/on_callback_call_support/domain/on_callback_call_support.dart';
import '../feature/on_callback_confirm/domain/on_callback_confirm.dart';
import '../feature/on_callback_support/feature/on_callback_faq/domain/on_callback_faq.dart';
import '../feature/on_callback_go_to/domain/on_callback_go_to.dart';
import '../feature/on_callback_my_orders/domain/on_callback_my_orders.dart';
import '../feature/on_callback_order/domain/on_callback_order.dart';
import '../feature/on_callback_order/feature/on_callback_order_beat/domain/on_callback_order_beat.dart';
import '../feature/on_callback_order/feature/on_callback_order_mastering/domain/on_callback_order_mastering.dart';
import '../feature/on_callback_order/feature/on_callback_order_mix/domain/on_callback_order_mix.dart';
import '../feature/on_callback_order/feature/on_callback_order_mix_and_mastering/domain/on_callback_order_mix_and_mastering.dart';
import '../feature/on_callback_support/domain/on_callback_support.dart';
import '../feature/on_callback_admin_access/feature/on_callback_support_requests/domain/on_callback_support_requests.dart';
import 'on_callback_listener.dart';

@Singleton(as: OnCallbackListener)
class OnCallbackListenerImpl implements OnCallbackListener {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final OnCallbackFaq onCallbackFaq;
  final OnCallbackGoTo onCallbackGoTo;
  final OnCallbackOrder onCallbackOrder;
  final OnCallbackConfirm onCallbackConfirm;
  final OnCallbackSupport onCallbackSupport;
  final OnCallbackOrderMix onCallbackOrderMix;
  final OnCallbackMyOrders onCallbackMyOrders;
  final OnCallbackOrderBeat onCallbackOrderBeat;
  final OnCallbackAdminAccess onCallbackAdminAccess;
  final OnCallbackCallSupport onCallbackCallSupport;
  final OnCallbackOrderMastering onCallbackOrderMastering;
  final OnCallbackSupportRequests onCallbackSupportRequests;
  final OnCallbackOrderMixAndMastering onCallbackOrderMixAndMastering;

  OnCallbackListenerImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.onCallbackFaq,
    required this.onCallbackGoTo,
    required this.onCallbackOrder,
    required this.onCallbackConfirm,
    required this.onCallbackSupport,
    required this.onCallbackOrderMix,
    required this.onCallbackMyOrders,
    required this.onCallbackOrderBeat,
    required this.onCallbackAdminAccess,
    required this.onCallbackCallSupport,
    required this.onCallbackOrderMastering,
    required this.onCallbackSupportRequests,
    required this.onCallbackOrderMixAndMastering,
  });

  @override
  void call(TeleDartCallbackQuery callback) async {
    logger.i('''Callback button pressed
Callback ID: ${callback.id}
Callback data: ${callback.data}
Callback triggerer: @${callback.from.username} (id${callback.from.id})''');

    final String? callbackData = callback.data;

    if (callbackData == null) return;

    final callbackAction = callbackData.split(':').first;

    try {
      switch (callbackAction) {
        case Constants.order:
          onCallbackOrder(callback);
          break;
        case Constants.orderMix:
          onCallbackOrderMix(callback);
          break;
        case Constants.orderMastering:
          onCallbackOrderMastering(callback);
          break;
        case Constants.orderMixAndMastering:
          onCallbackOrderMixAndMastering(callback);
          break;
        case Constants.orderBeat:
          onCallbackOrderBeat(callback);
          break;
        case Constants.goTo:
          onCallbackGoTo(callback);
          break;
        case Constants.confirm:
          onCallbackConfirm(callback);
          break;
        case Constants.myOrders:
          onCallbackMyOrders(
            callback,
            showMoreButton: callbackData.split(':').last != Constants.more,
          );
          break;
        case Constants.support:
          onCallbackSupport(callback);
          break;
        case Constants.faq:
          onCallbackFaq(callback);
          break;
        case Constants.callSupport:
          onCallbackCallSupport(callback);
          break;
        case Constants.adminAccess:
          onCallbackAdminAccess(callback);
          break;
        case Constants.supportRequests:
          onCallbackSupportRequests(callback);
          break;
        default:
          await teledart.answerCallbackQuery(
            callback.id,
            text: translations.errors.not_implemented,
            showAlert: true,
          );
          break;
      }
    } catch (error) {
      logger.e('Failed to answer callback query', error: error);
    }
  }
}
