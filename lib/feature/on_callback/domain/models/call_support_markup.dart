import 'package:fakelab_records_bot/core/constants/constants.dart';

import '../../../../core/i18n/app_localization.g.dart';
import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

@singleton
class CallSupportMarkup {
  final Translations translations;

  CallSupportMarkup({required this.translations});

  InlineKeyboardMarkup call() {
    final InlineKeyboardButton goGack = InlineKeyboardButton(
      text: translations.buttons.go_back,
      callbackData: '${Constants.goTo}:${Constants.support}',
    );

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [goGack],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
