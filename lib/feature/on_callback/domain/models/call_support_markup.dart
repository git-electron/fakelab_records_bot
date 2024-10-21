import '../../../../core/i18n/app_localization.g.dart';
import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

@singleton
class CallSupportMarkup {
  final Translations translations;

  CallSupportMarkup({required this.translations});

  InlineKeyboardMarkup call() {
    final InlineKeyboardButton cancel = InlineKeyboardButton(
      text: translations.buttons.cancel,
      callbackData: 'go_to:support',
    );

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [cancel],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
