import 'dart:convert';

import 'package:footloose_app/core/error/exceptions.dart';
import 'package:footloose_app/core/shared_preferences_key.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RequestType { get, post }

class RequestBuilder {
  RequestBuilder({
    required this.httpClient,
    required this.sharedPreferences,
  });

  final Client httpClient;
  final SharedPreferences sharedPreferences;

  Future<Response> request(
    String endpoint,
    RequestType requestType, {
    Map<String, dynamic>? body,
    bool withAuthentication = false,
  }) async {
    const apiHost = '192.168.0.12:3000';
    final url = Uri.http(apiHost, endpoint);
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      if (withAuthentication) {
        final token = sharedPreferences.getString(Preferences.token) ?? '';
        headers.addAll({'x-token': token});
      }
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
      print(e);
      throw RequestException();
    }
  }
}
