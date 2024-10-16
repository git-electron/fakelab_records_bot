import '../../../../../core/constants/constants.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/i18n/app_localization.g.dart';

import 'on_start_command.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: OnStartCommand)
class OnStartCommandImpl implements OnStartCommand {
  final Logger logger;
  final TeleDart teledart;

  OnStartCommandImpl({
    required this.logger,
    required this.teledart,
  });

  @override
  void call(TeleDartMessage message) {
    final Translations t = injector.get();

    teledart.sendMessage(
      message.chat.id,
      t.texts.start_command_text_registered(
        firstName: message.from?.firstName ?? t.user,
      ),
      parseMode: 'Markdown',
      replyMarkup: _replyMarkup,
    );
  }

  InlineKeyboardMarkup get _replyMarkup {
    final Translations t = injector.get();

    final InlineKeyboardButton openApp = InlineKeyboardButton(
      text: t.buttons.open_app,
      url: Constants.webAppUrl,
    );
    final InlineKeyboardButton order = InlineKeyboardButton(
      text: t.buttons.order,
      callbackData: 'order',
    );
    final InlineKeyboardButton myOrders = InlineKeyboardButton(
      text: t.buttons.my_orders,
      callbackData: 'my_orders',
    );
    final InlineKeyboardButton myBookings = InlineKeyboardButton(
      text: t.buttons.my_bookings,
      callbackData: 'my_bookings',
    );
    final InlineKeyboardButton support = InlineKeyboardButton(
      text: t.buttons.support,
      callbackData: 'support',
    );

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [openApp],
      [order],
      [myOrders, myBookings],
      [support],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
