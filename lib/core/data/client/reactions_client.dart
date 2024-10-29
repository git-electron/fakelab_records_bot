import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:teledart/model.dart';
import 'package:teledart/util.dart';

@singleton
class ReactionsClient {
  static bool _nullFilter(_, value) => value == null;

  static Future<dynamic> httpPost(Uri url, {Map<String, dynamic>? body}) async {
    body?.removeWhere(_nullFilter);
    return http
        .post(url, body: body?.map((k, v) => MapEntry(k, '$v')))
        .then(_parseResponse)
        .catchError((error) => Future.error(error));
  }

  static Future<dynamic> _parseResponse(http.Response response) {
    Map<String, dynamic> jsonBody = jsonDecode(response.body);
    Response responseBody = Response.fromJson(jsonBody);
    if (responseBody.ok) {
      return Future.value(SuccessResponse.fromJson(jsonBody).result);
    } else {
      ErrorResponse errorResponse = ErrorResponse.fromJson(jsonBody);
      return Future.error(HttpClientException(errorResponse.errorCode,
          errorResponse.description, errorResponse.parameters));
    }
  }
}
