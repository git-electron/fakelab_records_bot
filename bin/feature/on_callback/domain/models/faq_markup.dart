import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/i18n/app_localization.g.dart';

@singleton
class FaqMarkup {
  final Translations translations;

  FaqMarkup({required this.translations});

  InlineKeyboardMarkup call(int userId) {
    final InlineKeyboardButton callSupport = InlineKeyboardButton(
      text: translations.buttons.call_support,
      callbackData: Constants.callSupport,
    );
    final InlineKeyboardButton goBack = InlineKeyboardButton(
      text: translations.buttons.go_back,
      callbackData: '${Constants.goTo}:${Constants.support}',
    );

    final bool isAdmin = Constants.adminAccountIds.contains(userId);

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      if(!isAdmin) [callSupport],
      [goBack],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
