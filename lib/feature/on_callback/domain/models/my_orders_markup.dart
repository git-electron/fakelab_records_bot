import '../../../../core/i18n/app_localization.g.dart';
import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

@singleton
class MyOrdersMarkup {
  final Translations translations;

  MyOrdersMarkup({required this.translations});

  InlineKeyboardMarkup call({
    required bool showMoreButton,
  }) {
    final InlineKeyboardButton goBack = InlineKeyboardButton(
      text: translations.buttons.go_back,
      callbackData: 'go_to:main_menu',
    );
    final InlineKeyboardButton showMore = InlineKeyboardButton(
      text: translations.buttons.show_more,
      callbackData: 'my_orders:more',
    );

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [goBack, if (showMoreButton) showMore],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
