import 'package:fakelab_records_bot/core/constants/constants.dart';

import '../../../../core/i18n/app_localization.g.dart';
import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

@singleton
class AdminAccessMarkup {
  final Translations translations;

  AdminAccessMarkup({required this.translations});

  InlineKeyboardMarkup call() {
    final InlineKeyboardButton supportRequests = InlineKeyboardButton(
      text: translations.admin.buttons.support_requests,
      callbackData: Constants.supportRequests,
    );
    final InlineKeyboardButton goBack = InlineKeyboardButton(
      text: translations.buttons.go_back,
      callbackData: '${Constants.goTo}:${Constants.support}',
    );

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [supportRequests],
      [goBack],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
