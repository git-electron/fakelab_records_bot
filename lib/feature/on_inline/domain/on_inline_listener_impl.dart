import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:injectable/injectable.dart';
import 'package:fakelab_records_bot/feature/on_inline/domain/on_inline_listener.dart';

@Singleton(as: OnInlineListener)
class OnInlineListenerImpl implements OnInlineListener {
  final Logger logger;

  OnInlineListenerImpl({required this.logger});

  @override
  void call(ChosenInlineResult result) {
    print('inline result chosen');
  }
}
