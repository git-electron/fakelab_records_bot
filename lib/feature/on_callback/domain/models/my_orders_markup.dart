import 'package:fakelab_records_bot/core/constants/constants.dart';

import '../../../../core/i18n/app_localization.g.dart';
import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

@singleton
class MyOrdersMarkup {
  final Translations translations;

  MyOrdersMarkup({required this.translations});

  InlineKeyboardMarkup call({
    required bool showMoreButton,
  }) {
    final InlineKeyboardButton goBack = InlineKeyboardButton(
      text: translations.buttons.go_back,
      callbackData: '${Constants.goTo}:${Constants.mainMenu}',
    );
    final InlineKeyboardButton showMore = InlineKeyboardButton(
      text: translations.buttons.show_more,
      callbackData: '${Constants.myOrders}:${Constants.more}',
    );

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [goBack, if (showMoreButton) showMore],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
