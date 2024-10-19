import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_confirm/domain/models/order_model.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_my_orders/data/repository/get_user_orders_repository.dart';
import 'package:fakelab_records_bot/feature/on_callback/feature/on_callback_my_orders/domain/service/get_user_orders_service.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:logger/logger.dart';

@Singleton(as: GetUserOrdersService)
class GetUserOrdersServiceImpl implements GetUserOrdersService {
  final Logger logger;
  final GetUserOrdersRepository getUserOrdersRepository;

  GetUserOrdersServiceImpl({
    required this.logger,
    required this.getUserOrdersRepository,
  });

  @override
  Future<List<Order>?> call(int userId, {required bool showMore}) async {
    try {
      final int limit = showMore ? 8 : 2;

      final List<Order>? orders = await getUserOrdersRepository(
        userId,
        limit: limit,
      );

      return orders;
    } catch (error) {
      logger.e('Failed to get user orders', error: error);
      return null;
    }
  }
}
