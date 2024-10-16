import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:fakelab_records_bot/feature/on_message/feature/on_contact_received/data/repository/create_user_repository.dart';
import 'package:fakelab_records_bot/feature/on_message/feature/on_contact_received/domain/on_contact_received.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart' hide User;
import 'package:teledart/teledart.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/domain/model/user_model.dart';

@Singleton(as: OnContactReceived)
class OnContactReceivedImpl implements OnContactReceived {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final CreateUserRepository createUserRepository;

  OnContactReceivedImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.createUserRepository,
  });

  @override
  void call(TeleDartMessage message, {required Contact contact}) async {
    if (contact.userId == null || message.from == null) return;

    final User user = User(
      id: contact.userId!,
      username: message.from!.username,
      firstName: contact.firstName,
      lastName: contact.lastName,
      phoneNumber: contact.phoneNumber,
    );

    await createUserRepository(user.id, user: user);

    teledart.sendMessage(
      message.chat.id,
      translations.texts.registered_text,
      replyMarkup: ReplyKeyboardRemove(removeKeyboard: true),
    );

    await Future.delayed(Duration(seconds: 1));

    _sendRegisteredMessage(message);
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
