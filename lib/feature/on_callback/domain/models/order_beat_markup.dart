import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/i18n/app_localization.g.dart';

@singleton
class OrderBeatMarkup {
  final Translations translations;

  OrderBeatMarkup({required this.translations});

  InlineKeyboardMarkup call() {
    final InlineKeyboardButton confirm = InlineKeyboardButton(
      text: translations.buttons.confirm,
      callbackData: '${Constants.confirm}:${Constants.orderBeat}',
    );
    final InlineKeyboardButton cancel = InlineKeyboardButton(
      text: translations.buttons.cancel,
      callbackData: '${Constants.goTo}:${Constants.order}',
    );

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [confirm],
      [cancel],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
