import 'package:fakelab_records_bot/core/domain/model/user_model.dart';
import 'package:fakelab_records_bot/core/domain/service/id_service.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/data/create_order_repository.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/data/get_user_request_order_repository.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/models/order_model.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/service/create_order_service.dart';
import 'package:fakelab_records_bot/feature/on_command/data/repository/get_user_repository.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:logger/logger.dart';

import '../models/order_filters_model.dart';
import '../models/order_service_model.dart';
import '../models/order_service_type.dart';
import '../models/order_status.dart';
import '../models/order_status_history_item_model.dart';
import '../models/order_type.dart';

@Singleton(as: CreateOrderService)
class CreateOrderServiceImpl implements CreateOrderService {
  final Logger logger;
  final IdService idService;
  final GetUserRepository getUserRepository;
  final CreateOrderRepository createOrderRepository;
  final GetUserRequestOrderRepository getUserRequestOrderRepository;

  CreateOrderServiceImpl({
    required this.logger,
    required this.idService,
    required this.getUserRepository,
    required this.createOrderRepository,
    required this.getUserRequestOrderRepository,
  });

  @override
  Future<Order?> call(
    int userId, {
    required OrderType orderType,
  }) async {
    try {
      final User? user = await getUserRepository(userId);

      if (user == null) {
        return null;
      }

      final String id = idService.generate();
      final DateTime now = DateTime.now();

      final String statusName = OrderStatus.REQUEST.name;
      final String typeName = orderType.name;

      final String userIdStatusType = '$userId-$statusName-$typeName';

      final Order order = Order(
        id: id,
        customer: user,
        type: orderType,
        status: OrderStatus.REQUEST,
        statusHistory: [
          OrderStatusHistoryItem(
            status: OrderStatus.REQUEST,
            dateChanged: now,
          ),
        ],
        dateCreated: now,
        totalCost: orderType.totalCost,
        costFrom: orderType.costFrom,
        services: _services(orderType),
        filters: OrderFilters(userIdStatusType: userIdStatusType),
      );

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

  List<OrderService> _services(OrderType orderType) {
    switch (orderType) {
      case OrderType.MIX:
        return [
          OrderService(
            type: OrderServiceType.MIX,
            totalCost: OrderServiceType.MIX.totalCost,
            costFrom: OrderServiceType.MIX.costFrom,
          ),
        ];
      case OrderType.MASTERING:
        return <OrderService>[
          OrderService(
            type: OrderServiceType.MASTERING,
            totalCost: OrderServiceType.MASTERING.totalCost,
            costFrom: OrderServiceType.MASTERING.costFrom,
          ),
        ];
      case OrderType.MIX_AND_MASTERING:
        return <OrderService>[
          OrderService(
            type: OrderServiceType.MIX,
            totalCost: OrderServiceType.MIX.totalCost,
            costFrom: OrderServiceType.MIX.costFrom,
          ),
          OrderService(
            type: OrderServiceType.MASTERING,
            totalCost: OrderServiceType.MASTERING.totalCost,
            costFrom: OrderServiceType.MASTERING.costFrom,
          ),
        ];
      case OrderType.BEAT:
        return <OrderService>[
          OrderService(
            type: OrderServiceType.BEAT,
            totalCost: OrderServiceType.BEAT.totalCost,
            costFrom: OrderServiceType.BEAT.costFrom,
          ),
        ];
      default:
        return <OrderService>[];
    }
  }
}
