import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/i18n/app_localization.g.dart';

@singleton
class AdminAccessMarkup {
  final Translations translations;

  AdminAccessMarkup({required this.translations});

  InlineKeyboardMarkup call() {
    final InlineKeyboardButton supportRequests = InlineKeyboardButton(
      text: translations.admin.buttons.support_requests,
      callbackData: Constants.supportRequests,
    );
    final InlineKeyboardButton mailings = InlineKeyboardButton(
      text: translations.admin.buttons.mailings,
      callbackData: Constants.mailings,
    );
    final InlineKeyboardButton blacklist = InlineKeyboardButton(
      text: translations.admin.buttons.blacklist,
      callbackData: Constants.blacklist,
    );
    final InlineKeyboardButton goBack = InlineKeyboardButton(
      text: translations.buttons.go_back,
      callbackData: '${Constants.goTo}:${Constants.mainMenu}',
    );

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [supportRequests, mailings],
      [blacklist],
      [goBack],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
