import '../../../../../core/i18n/app_localization.g.dart';
import 'on_callback_go_to.dart';
import '../../on_callback_main_menu/domain/on_callback_main_menu.dart';
import '../../on_callback_order/domain/on_callback_order.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnCallbackGoTo)
class OnCallbackGoToImpl implements OnCallbackGoTo {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final OnCallbackOrder onCallbackOrder;
  final OnCallbackMainMenu onCallbackMainMenu;

  OnCallbackGoToImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.onCallbackOrder,
    required this.onCallbackMainMenu,
  });

  @override
  void call(TeleDartCallbackQuery callback) {
    final Message? message = callback.message;
    final String? to = callback.data?.split(':').last;

    if (message == null || to == null) return;

    switch (to) {
      case 'main_menu':
        onCallbackMainMenu(callback);
        break;
      case 'order':
        onCallbackOrder(callback);
        break;
      default:
        onCallbackMainMenu(callback);
        break;
    }
  }
}
