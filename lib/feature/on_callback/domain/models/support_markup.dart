import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/i18n/app_localization.g.dart';

@singleton
class SupportMarkup {
  final Translations translations;

  SupportMarkup({required this.translations});

  InlineKeyboardMarkup call(int userId) {
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

    final bool isAdmin = Constants.adminAccountIds.contains(userId);

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [faq, if (!isAdmin) callSupport],
      [goBack],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
