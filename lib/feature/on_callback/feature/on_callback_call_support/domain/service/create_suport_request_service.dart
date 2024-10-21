import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';

abstract class CreateSuportRequestService {
  Future<SupportRequest?> call(int userId);
}
