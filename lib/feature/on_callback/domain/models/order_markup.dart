import '../../../../core/constants/constants.dart';
import '../../../../core/i18n/app_localization.g.dart';
import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

@singleton
class OrderMarkup {
  final Translations translations;

  OrderMarkup({required this.translations});

  InlineKeyboardMarkup call() {
    final InlineKeyboardButton bookRecording = InlineKeyboardButton(
      text: translations.buttons.book_recording,
      url: Constants.webAppUrl,
    );
    final InlineKeyboardButton orderMix = InlineKeyboardButton(
      text: translations.buttons.order_mix,
      callbackData: 'order_mix',
    );
    final InlineKeyboardButton orderMastering = InlineKeyboardButton(
      text: translations.buttons.order_mastering,
      callbackData: 'order_mastering',
    );
    final InlineKeyboardButton orderMixAndMastering = InlineKeyboardButton(
      text: translations.buttons.order_mix_and_mastering,
      callbackData: 'order_mix_and_mastering',
    );
    final InlineKeyboardButton orderBeat = InlineKeyboardButton(
      text: translations.buttons.order_beat,
      callbackData: 'order_beat',
    );
    final InlineKeyboardButton goBack = InlineKeyboardButton(
      text: translations.buttons.go_back,
      callbackData: 'go_to:main_menu',
    );

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [bookRecording],
      [orderMix, orderMastering],
      [orderMixAndMastering],
      [orderBeat],
      [goBack],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
