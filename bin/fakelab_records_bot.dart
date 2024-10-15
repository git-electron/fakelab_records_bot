import 'dart:async';

import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

const telegramApiKey = '7773023725:AAHsNSD2rSv28HzLQj1D509oip221fAmULg';

Future<void> main() async {
  final telegram = Telegram(telegramApiKey);
  final event = Event((await telegram.getMe()).username!);
  final teledart = TeleDart(telegramApiKey, event);

  teledart.start();

  teledart.onCommand('start').listen((message) {
    // create buttons
    final testButton = KeyboardButton(text: 'One button');
    final anotheButton = KeyboardButton(text: 'Another button');

    // arrange buttons boy two in line
    final twoButtonList = [testButton, anotheButton];

    // grab all buttons together
    final markup = ReplyKeyboardMarkup(
      keyboard: [twoButtonList],
    );

    // send message to user
    teledart.sendMessage(
      message.chat.id,
      'Try it',
      replyMarkup: markup,
    );
  });

  teledart.onMessage(keyword: 'Another button').listen((message) {
    final testButton = KeyboardButton(text: 'One button');
    final anotheButton = KeyboardButton(text: 'Another button');

    final twoButtonList = [testButton, anotheButton];

    final markup = ReplyKeyboardMarkup(
      keyboard: [twoButtonList],
    );

    teledart.sendMessage(
      message.chat.id,
      'Try it: Another button',
      replyMarkup: markup,
    );
  });

  teledart.onMessage(keyword: 'One button').listen((message) {
    final testButton = KeyboardButton(text: 'One button');
    final anotheButton = KeyboardButton(text: 'Another button');

    final twoButtonList = [testButton, anotheButton];

    final markup = ReplyKeyboardMarkup(
      keyboard: [twoButtonList],
    );

    teledart.sendMessage(
      message.chat.id,
      'Try it: One button',
      replyMarkup: markup,
    );
  });

  teledart.onMessage().listen((message) {
    if (message.text != 'One button' &&
        message.text != 'Another button' &&
        message.photo == null) {
      teledart.sendMessage(
        message.chat.id,
        'Nice try',
      );
    }
  });
}
