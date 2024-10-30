import 'package:injectable/injectable.dart';

import 'id_service.dart';

@Singleton(as: IdService)
class IdServiceImpl implements IdService {
  @override
  String generate() {
    final DateTime future = DateTime(2200);
    final DateTime now = DateTime.now();

    final int microseconds = future.difference(now).inMicroseconds;
    return '$microseconds';
  }
}
