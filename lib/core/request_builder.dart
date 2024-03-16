import 'dart:convert';

import 'package:footloose_app/core/error/exceptions.dart';
import 'package:http/http.dart';

enum RequestType { get, post }

class RequestBuilder {
  RequestBuilder({
    required this.httpClient,
  });

  final Client httpClient;

  Future<Response> request(
    String endpoint,
    RequestType requestType, {
    Map<String, dynamic>? body,
  }) async {
    const apiHost = '192.168.0.12:3000';
    final url = Uri.http(apiHost, endpoint);
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      switch (requestType) {
        case RequestType.get:
          return await httpClient.get(url, headers: headers);
        case RequestType.post:
          return await httpClient.post(
            url,
            headers: headers,
            body: json.encode(body),
          );
      }
    } catch (e) {
      throw RequestException();
    }
  }
}
