import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/i18n/app_localization.g.dart';
import '../../../../on_callback/domain/models/support_markup.dart';
import 'on_support_command.dart';

@Singleton(as: OnSupportCommand)
class OnSupportCommandImpl implements OnSupportCommand {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final SupportMarkup supportMarkup;

  OnSupportCommandImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.supportMarkup,
  });

  @override
  void call(TeleDartMessage message) async {
    try {
      if (message.from == null) return;

      await teledart.sendMessage(
        message.chat.id,
        translations.texts.support_text,
        parseMode: Constants.parseMode,
        replyMarkup: supportMarkup(message.from!.id),
      );
    } catch (error) {
      logger.e(error);
    }
  }
}
