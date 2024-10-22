import '../../../../core/constants/constants.dart';

import '../../../../core/i18n/app_localization.g.dart';
import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

@singleton
class SupportMarkup {
  final Translations translations;

  SupportMarkup({required this.translations});

  InlineKeyboardMarkup call() {
    final InlineKeyboardButton faq = InlineKeyboardButton(
      text: translations.buttons.faq,
      callbackData: Constants.faq,
    );
    final InlineKeyboardButton callSupport = InlineKeyboardButton(
      text: translations.buttons.call_support,
      callbackData: Constants.callSupport,
    );
    final InlineKeyboardButton goBack = InlineKeyboardButton(
      text: translations.buttons.go_back,
      callbackData: '${Constants.goTo}:${Constants.mainMenu}',
    );

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [faq, callSupport],
      [goBack],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
