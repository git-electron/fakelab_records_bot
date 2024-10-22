import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/i18n/app_localization.g.dart';

@singleton
class FaqMarkup {
  final Translations translations;

  FaqMarkup({required this.translations});

  InlineKeyboardMarkup call() {
    final InlineKeyboardButton callSupport = InlineKeyboardButton(
      text: translations.buttons.call_support,
      callbackData: Constants.callSupport,
    );
    final InlineKeyboardButton goBack = InlineKeyboardButton(
      text: translations.buttons.go_back,
      callbackData: '${Constants.goTo}:${Constants.support}',
    );

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [callSupport],
      [goBack],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
