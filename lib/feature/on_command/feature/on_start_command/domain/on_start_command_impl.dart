import 'package:fakelab_records_bot/feature/on_command/feature/on_start_command/data/repository/get_user_repository.dart';
import 'package:teledart/teledart.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/i18n/app_localization.g.dart';

import '../../../../../core/domain/model/user_model.dart';
import 'on_start_command.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart' hide User;
import 'package:injectable/injectable.dart';

@Singleton(as: OnStartCommand)
class OnStartCommandImpl implements OnStartCommand {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final GetUserRepository getUserRepository;

  OnStartCommandImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.getUserRepository,
  });

  @override
  void call(TeleDartMessage message) async {
    final User? user = await getUserRepository(message.from!.id);

    if (user == null) {
      _sendUnregisteredMessage(message);
    } else {
      _sendRegisteredMessage(message);
    }
  }

  void _sendUnregisteredMessage(TeleDartMessage message) {
    teledart.sendMessage(
      message.chat.id,
      translations.texts.start_command_text_unregistered(
        firstName: message.from?.firstName ?? translations.user,
      ),
      parseMode: 'Markdown',
      replyMarkup: _replyMarkupUnregistered,
    );
  }

  ReplyKeyboardMarkup get _replyMarkupUnregistered {
    final KeyboardButton shareContact = KeyboardButton(
      text: translations.buttons.share_contact,
      requestContact: true,
    );

    final List<List<KeyboardButton>> keyboard = [
      [shareContact],
    ];

    final ReplyKeyboardMarkup markup = ReplyKeyboardMarkup(
      keyboard: keyboard,
      resizeKeyboard: true,
      oneTimeKeyboard: true,
    );

    return markup;
  }

  void _sendRegisteredMessage(TeleDartMessage message) {
    teledart.sendMessage(
      message.chat.id,
      translations.texts.start_command_text_registered(
        firstName: message.from?.firstName ?? translations.user,
      ),
      parseMode: 'Markdown',
      replyMarkup: _replyMarkupRegistered,
    );
  }

  InlineKeyboardMarkup get _replyMarkupRegistered {
    final InlineKeyboardButton openApp = InlineKeyboardButton(
      text: translations.buttons.open_app,
      url: Constants.webAppUrl,
    );
    final InlineKeyboardButton order = InlineKeyboardButton(
      text: translations.buttons.order,
      callbackData: 'order',
    );
    final InlineKeyboardButton myOrders = InlineKeyboardButton(
      text: translations.buttons.my_orders,
      callbackData: 'my_orders',
    );
    final InlineKeyboardButton myBookings = InlineKeyboardButton(
      text: translations.buttons.my_bookings,
      callbackData: 'my_bookings',
    );
    final InlineKeyboardButton support = InlineKeyboardButton(
      text: translations.buttons.support,
      callbackData: 'support',
    );

    final List<List<InlineKeyboardButton>> inlineKeyboard = [
      [openApp],
      [order],
      [myOrders, myBookings],
      [support],
    ];

    final InlineKeyboardMarkup markup = InlineKeyboardMarkup(
      inlineKeyboard: inlineKeyboard,
    );

    return markup;
  }
}
