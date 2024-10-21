import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';

abstract class CreateSupportRequestRepository {
  Future<SupportRequest?> call(SupportRequest request);
}
