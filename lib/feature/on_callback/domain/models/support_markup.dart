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
    final InlineKeyboardButton goToMainMenu = InlineKeyboardButton(
      text: translations.buttons.go_to_main_menu,
      callbackData: 'go_to:main_menu',
    );

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [faq, callSupport],
      [goToMainMenu],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
