import '../../../on_callback_confirm/domain/models/order_model.dart';
import '../../data/repository/get_user_orders_repository.dart';
import 'get_user_orders_service.dart';
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
