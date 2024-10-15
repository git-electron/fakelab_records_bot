import 'dart:async';
import 'dart:io';

import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import 'package:dotenv/dotenv.dart';

Future<void> main() async {
  var env = DotEnv()..load();

  final String? apiToken = env['API_TOKEN'];

  if (apiToken == null) exit(0);

  final telegram = Telegram(apiToken);
  final event = Event((await telegram.getMe()).username!);
  final teledart = TeleDart(apiToken, event);

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
