import 'package:fakelab_records_bot/core/domain/model/user_model.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/data/create_order_repository.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/data/get_user_request_order_repository.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/models/order_model.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/service/create_order_service.dart';
import 'package:fakelab_records_bot/feature/on_command/data/repository/get_user_repository.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:logger/logger.dart';

@Singleton(as: CreateOrderService)
class CreateOrderServiceImpl implements CreateOrderService {
  final Logger logger;
  final GetUserRepository getUserRepository;
  final CreateOrderRepository createOrderRepository;
  final GetUserRequestOrderRepository getUserRequestOrderRepository;

  CreateOrderServiceImpl({
    required this.logger,
    required this.getUserRepository,
    required this.createOrderRepository,
    required this.getUserRequestOrderRepository,
  });

  @override
  Future<Order?> call(Order order, {required User user}) async {
    try {
      final Order? requestOrder = await getUserRequestOrderRepository(
        user.id,
        orderType: order.type,
      );

      if (requestOrder != null) {
        return null;
      }

      await createOrderRepository(order);
      return order;
    } catch (error) {
      logger.e('Failed to create order', error: error);
      return null;
    }
  }
}
