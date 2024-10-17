import '../../../../core/i18n/app_localization.g.dart';
import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

import '../../../../core/constants/constants.dart';

@singleton
class MainMenuMarkup {
  final Translations translations;

  MainMenuMarkup({required this.translations});

  InlineKeyboardMarkup call() {
    final InlineKeyboardButton openApp = InlineKeyboardButton(
      text: translations.buttons.open_app,
      url: Constants.webAppUrl,
    );
    final InlineKeyboardButton order = InlineKeyboardButton(
      text: translations.buttons.order,
      callbackData: 'order',
    );
    final InlineKeyboardButton myOrders = InlineKeyboardButton(
      text: translations.buttons.my_orders,
      callbackData: 'my_orders',
    );
    final InlineKeyboardButton myBookings = InlineKeyboardButton(
      text: translations.buttons.my_bookings,
      callbackData: 'my_bookings',
    );
    final InlineKeyboardButton support = InlineKeyboardButton(
      text: translations.buttons.support,
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
