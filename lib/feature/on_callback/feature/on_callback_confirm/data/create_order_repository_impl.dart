import 'create_order_repository.dart';
import '../domain/models/order_model.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:logger/logger.dart';

@Singleton(as: CreateOrderRepository)
class CreateOrderRepositoryImpl implements CreateOrderRepository {
  final Logger logger;

  CreateOrderRepositoryImpl({
    required this.logger,
  });

  @override
  Future<void> call(Order order) async {
    return;
  }
}
