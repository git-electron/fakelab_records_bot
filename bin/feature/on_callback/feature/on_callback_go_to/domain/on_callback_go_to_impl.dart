import '../../on_callback_admin_access/feature/on_callback_support_requests/domain/on_callback_support_requests.dart';

import '../../../../../core/constants/constants.dart';
import '../../on_callback_admin_access/domain/on_callback_admin_access.dart';
import '../../on_callback_support/domain/on_callback_support.dart';

import '../../../../../core/i18n/app_localization.g.dart';
import 'on_callback_go_to.dart';
import '../../on_callback_main_menu/domain/on_callback_main_menu.dart';
import '../../on_callback_order/domain/on_callback_order.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';

@Singleton(as: OnCallbackGoTo)
class OnCallbackGoToImpl implements OnCallbackGoTo {
  final Logger logger;
  final Translations translations;
  final OnCallbackOrder onCallbackOrder;
  final OnCallbackSupport onCallbackSupport;
  final OnCallbackMainMenu onCallbackMainMenu;
  final OnCallbackAdminAccess onCallbackAdminAccess;
  final OnCallbackSupportRequests onCallbackSupportRequests;

  OnCallbackGoToImpl({
    required this.logger,
    required this.translations,
    required this.onCallbackOrder,
    required this.onCallbackSupport,
    required this.onCallbackMainMenu,
    required this.onCallbackAdminAccess,
    required this.onCallbackSupportRequests,
  });

  @override
  void call(TeleDartCallbackQuery callback) {
    try {
      final Message? message = callback.message;
      final String? to = callback.data?.split(':').last;

      if (message == null || to == null) return;

      switch (to) {
        case Constants.mainMenu:
          onCallbackMainMenu(callback);
          break;
        case Constants.order:
          onCallbackOrder(callback);
          break;
        case Constants.support:
          onCallbackSupport(callback);
          break;
        case Constants.adminAccess:
          onCallbackAdminAccess(callback);
          break;
        case Constants.supportRequests:
          onCallbackSupportRequests(callback);
          break;
        default:
          onCallbackMainMenu(callback);
          break;
      }
    } catch (error) {
      logger.e(error);
    }
  }
}
