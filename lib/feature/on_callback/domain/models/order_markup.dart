import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/i18n/app_localization.g.dart';

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
      callbackData: Constants.orderMix,
    );
    final InlineKeyboardButton orderMastering = InlineKeyboardButton(
      text: translations.buttons.order_mastering,
      callbackData: Constants.orderMastering,
    );
    final InlineKeyboardButton orderMixAndMastering = InlineKeyboardButton(
      text: translations.buttons.order_mix_and_mastering,
      callbackData: Constants.orderMixAndMastering,
    );
    final InlineKeyboardButton orderBeat = InlineKeyboardButton(
      text: translations.buttons.order_beat,
      callbackData: Constants.orderBeat,
    );
    final InlineKeyboardButton goBack = InlineKeyboardButton(
      text: translations.buttons.go_back,
      callbackData: '${Constants.goTo}:${Constants.mainMenu}',
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
