import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/i18n/app_localization.g.dart';

@singleton
class OnMailingCompleteMarkup {
  final Translations translations;

  OnMailingCompleteMarkup({required this.translations});

  InlineKeyboardMarkup call() {
    final InlineKeyboardButton goToMainMenu = InlineKeyboardButton(
      text: translations.buttons.go_to_main_menu,
      callbackData: '${Constants.goTo}:${Constants.mainMenu}',
    );

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [goToMainMenu],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
