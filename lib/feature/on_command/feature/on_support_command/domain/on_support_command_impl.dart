import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart';
import 'package:fakelab_records_bot/feature/on_callback/domain/models/support_markup.dart';
import 'package:fakelab_records_bot/feature/on_command/feature/on_support_command/domain/on_support_command.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

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
      await teledart.sendMessage(
        message.chat.id,
        translations.texts.support_text,
        parseMode: 'HTML',
        replyMarkup: supportMarkup(),
      );
    } catch (error) {
      logger.e(error);
    }
  }
}
