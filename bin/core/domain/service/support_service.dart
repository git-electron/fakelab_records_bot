import '../model/support_request_model.dart';

abstract class SupportService {
  List<SupportRequest> get supportRequests;

  void listenToSupportRequests();
}
