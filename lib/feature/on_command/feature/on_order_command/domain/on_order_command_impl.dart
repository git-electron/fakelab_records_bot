import '../../../../../core/i18n/app_localization.g.dart';
import '../../../../on_callback/domain/models/order_markup.dart';
import 'on_order_command.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart' hide User;
import 'package:teledart/teledart.dart';

@Singleton(as: OnOrderCommand)
class OnOrderCommandImpl implements OnOrderCommand {
  final Logger logger;
  final TeleDart teledart;
  final OrderMarkup orderMarkup;
  final Translations translations;

  OnOrderCommandImpl({
    required this.logger,
    required this.teledart,
    required this.orderMarkup,
    required this.translations,
  });

  @override
  void call(TeleDartMessage message) {
    teledart.sendMessage(
      message.chat.id,
      translations.texts.order_text,
      parseMode: 'HTML',
      replyMarkup: orderMarkup(),
    );
  }
}
