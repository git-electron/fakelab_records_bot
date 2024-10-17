import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/data/get_user_request_order_repository.dart';
import 'package:firebase_dart/database.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:logger/logger.dart';

import '../domain/models/order_model.dart';

@Singleton(as: GetUserRequestOrderRepository)
class GetUserRequestOrderRepositoryImpl
    implements GetUserRequestOrderRepository {
  final Logger logger;
  final DatabaseReference reference;

  GetUserRequestOrderRepositoryImpl({
    required this.logger,
    required this.reference,
  });

  @override
  Future<Order?> call(int userId) async {
    try {
      final String path = 'orders';
      final Map<String, dynamic>? data =
          await reference.child(path).equalTo(userId, key: 'customer.id').get();

      logger.i('''Realtime Database request:
Path: $path
Data: $data''');

      if (data == null) return null;

      final Order order = Order.fromJson(data);
      return order;
    } catch (error) {
      logger.e('Failed to get user', error: error);
      return null;
    }
  }
}
