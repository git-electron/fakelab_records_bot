import 'package:fakelab_records_bot/core/domain/model/user_model.dart';
import 'package:fakelab_records_bot/core/domain/service/id_service.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/models/order_filters_model.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/models/order_service_model.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/models/order_service_type.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/models/order_status.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/models/order_status_history_item_model.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/models/order_type.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/service/create_order_service.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/feature/on_confirm_order_mix/domain/service/create_mix_order_service.dart';
import 'package:fakelab_records_bot/feature/on_command/data/repository/get_user_repository.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:logger/logger.dart';

import '../../../../domain/models/order_model.dart';

@Singleton(as: CreateMixOrderService)
class CreateMixOrderServiceImpl implements CreateMixOrderService {
  final Logger logger;
  final IdService idService;
  final GetUserRepository getUserRepository;
  final CreateOrderService createOrderService;

  CreateMixOrderServiceImpl({
    required this.logger,
    required this.idService,
    required this.getUserRepository,
    required this.createOrderService,
  });

  @override
  Future<Order?> call(int userId) async {
    try {
      final User? user = await getUserRepository(userId);

      if (user == null) {
        return null;
      }

      final String id = idService.generate();
      final DateTime now = DateTime.now();

      final String statusName = OrderStatus.REQUEST.name;
      final String typeName = OrderType.MIX.name;

      final String userIdStatusType = '$userId-$statusName-$typeName';

      final Order order = Order(
        id: id,
        customer: user,
        type: OrderType.MIX,
        status: OrderStatus.REQUEST,
        statusHistory: [
          OrderStatusHistoryItem(
            status: OrderStatus.REQUEST,
            dateChanged: now,
          ),
        ],
        dateCreated: now,
        totalCost: 2500,
        costFrom: true,
        services: [
          OrderService(
            type: OrderServiceType.MIX,
            totalCost: 2500,
            costFrom: true,
          ),
        ],
        filters: OrderFilters(userIdStatusType: userIdStatusType),
      );

      final Order? createdOrder = await createOrderService(order, user: user);
      return createdOrder;
    } catch (error) {
      logger.e('Failed to create mix order', error: error);
      return null;
    }
  }
}
