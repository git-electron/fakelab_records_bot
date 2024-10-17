import 'id_service.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IdService)
class IdServiceImpl implements IdService {
  @override
  String generate() {
    final int microsecondsSinceEpoch = DateTime.now().microsecondsSinceEpoch;
    return '$microsecondsSinceEpoch';
  }
}
