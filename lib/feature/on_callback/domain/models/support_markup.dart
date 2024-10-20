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
      callbackData: 'faq',
    );
    final InlineKeyboardButton callSupport = InlineKeyboardButton(
      text: translations.buttons.call_support,
      callbackData: 'call_support',
    );
    final InlineKeyboardButton goBack = InlineKeyboardButton(
      text: translations.buttons.go_back,
      callbackData: 'go_to:main_menu',
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
