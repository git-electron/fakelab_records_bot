import '../../../../../core/i18n/app_localization.g.dart';
import 'on_callback_confirm.dart';
import '../feature/on_confirm_order_mix/domain/on_confirm_order_mix.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

@Singleton(as: OnCallbackConfirm)
class OnCallbackConfirmImpl implements OnCallbackConfirm {
  final Logger logger;
  final TeleDart teledart;
  final Translations translations;
  final OnConfirmOrderMix onConfirmOrderMix;

  OnCallbackConfirmImpl({
    required this.logger,
    required this.teledart,
    required this.translations,
    required this.onConfirmOrderMix,
  });

  @override
  void call(TeleDartCallbackQuery callback) {
    final Message? message = callback.message;
    final String? item = callback.data?.split(':').last;

    if (message == null || item == null) return;

    switch (item) {
      case 'order_mix':
        onConfirmOrderMix(callback);
        break;
      default:
        teledart.answerCallbackQuery(
          callback.id,
          text: translations.errors.not_implemented,
          showAlert: true,
        );
        break;
    }
  }
}
