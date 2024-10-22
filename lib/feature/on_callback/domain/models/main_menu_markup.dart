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
      callbackData: Constants.order,
    );
    final InlineKeyboardButton myOrders = InlineKeyboardButton(
      text: translations.buttons.my_orders,
      callbackData: Constants.myOrders,
    );
    final InlineKeyboardButton myBookings = InlineKeyboardButton(
      text: translations.buttons.my_bookings,
      callbackData: Constants.myBookings,
    );
    final InlineKeyboardButton support = InlineKeyboardButton(
      text: translations.buttons.support,
      callbackData: Constants.support,
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
