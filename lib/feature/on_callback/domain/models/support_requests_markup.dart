import '../../../../core/constants/constants.dart';

import '../../../../core/i18n/app_localization.g.dart';
import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

@singleton
class SupportRequestsMarkup {
  final Translations translations;

  SupportRequestsMarkup({required this.translations});

  InlineKeyboardMarkup call() {
    final InlineKeyboardButton goBack = InlineKeyboardButton(
      text: translations.buttons.go_back,
      callbackData: '${Constants.goTo}:${Constants.adminAccess}',
    );

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [goBack],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
