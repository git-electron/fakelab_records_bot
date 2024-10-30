import 'package:firebase_dart/database.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:logger/logger.dart';

import '../domain/models/order_model.dart';
import 'create_order_repository.dart';

@Singleton(as: CreateOrderRepository)
class CreateOrderRepositoryImpl implements CreateOrderRepository {
  final Logger logger;
  final DatabaseReference reference;

  CreateOrderRepositoryImpl({
    required this.logger,
    required this.reference,
  });

  @override
  Future<void> call(Order order) async {
    try {
      final String orderId = order.id;
      final String path = 'orders/$orderId';
      final Map<String, dynamic> data = order.toJson();
      await reference.child(path).set(data);

      logger.i('''Realtime Database creation request:
Path: $path
Data: $data''');
    } catch (error) {
      logger.e('Failed to create order', error: error);
    }
  }
}
