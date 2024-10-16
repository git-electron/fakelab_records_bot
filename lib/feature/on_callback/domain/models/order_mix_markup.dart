import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

@singleton
class OrderMixMarkup {
  final Translations translations;

  OrderMixMarkup({required this.translations});

  InlineKeyboardMarkup call() {
    final InlineKeyboardButton confirm = InlineKeyboardButton(
      text: translations.buttons.confirm,
      callbackData: 'confirm:order_mix',
    );
    final InlineKeyboardButton cancel = InlineKeyboardButton(
      text: translations.buttons.cancel,
      callbackData: 'go_to:order',
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
