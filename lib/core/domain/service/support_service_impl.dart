import 'package:fakelab_records_bot/core/domain/model/support_request_model.dart';
import 'package:fakelab_records_bot/core/domain/service/support_service.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Singleton(as: SupportService)
class SupportServiceImpl implements SupportService {
  final Logger logger;
  final DatabaseReference reference;

  SupportServiceImpl({
    required this.logger,
    required this.reference,
  });

  List<SupportRequest> _supportRequests = [];

  @override
  List<SupportRequest> get supportRequests => _supportRequests;

  @PostConstruct()
  @override
  void listenToSupportRequests() async {
    try {
      final String path = 'support_requests';

      reference.child(path).onValue.listen((Event event) {
        final DataSnapshot snapshot = event.snapshot;
        final Map<String, dynamic>? data = snapshot.value;

        logger.i('''Realtime Database event from stream:
Path: $path
Data: $data''');

        if (data == null) {
          _supportRequests = [];
          return;
        }

        final List<SupportRequest> requests = [];

        for (var requestJson in data.values) {
          final SupportRequest request = SupportRequest.fromJson(requestJson);
          requests.add(request);
        }

        _supportRequests = requests;
      }).onError(throw Exception());
    } catch (error) {
      logger.e('Failed to get support requests', error: error);
    }
  }
}
