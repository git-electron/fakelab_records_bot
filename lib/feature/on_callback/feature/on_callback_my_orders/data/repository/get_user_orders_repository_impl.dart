import '../../../on_callback_confirm/domain/models/order_model.dart';
import 'get_user_orders_repository.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:logger/logger.dart';

@Singleton(as: GetUserOrdersRepository)
class GetUserOrdersRepositoryImpl implements GetUserOrdersRepository {
  final Logger logger;
  final DatabaseReference reference;

  GetUserOrdersRepositoryImpl({
    required this.logger,
    required this.reference,
  });

  @override
  Future<List<Order>?> call(
    int userId, {
    required int limit,
  }) async {
    try {
      final String path = 'orders';
      final Map<String, dynamic>? data = await reference
          .child(path)
          .orderByChild('customer/id')
          .equalTo(userId)
          .limitToFirst(limit)
          .get();

      logger.i('''Realtime Database request limit $limit:
Path: $path
Data: $data''');

      if (data == null) return null;

      final List ordersJson = data.values.toList();

      return ordersJson.map((orderJson) => Order.fromJson(orderJson)).toList();
    } catch (error) {
      logger.e('Failed to get user orders', error: error);
      return null;
    }
  }
}
