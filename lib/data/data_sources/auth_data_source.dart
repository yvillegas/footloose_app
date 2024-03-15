import 'dart:convert';

import 'package:footloose_app/core/error/exceptions.dart';
import 'package:footloose_app/core/request_builder.dart';
import 'package:footloose_app/domain/models/auth_response.dart';

abstract class AuthDataSource {
  Future<AuthResponse> loginUser(String email, String password);
}

class AuthDataSourceImpl implements AuthDataSource {
  const AuthDataSourceImpl({
    required this.requestBuilder,
  });

  final RequestBuilder requestBuilder;

  @override
  Future<AuthResponse> loginUser(String email, String password) async {
    const endpoint = '/api/auth';
    final body = {
      'email': email,
      'password': password,
    };
    final response = await requestBuilder.request(
      endpoint,
      RequestType.post,
      body: body,
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as Map<String, dynamic>;
      final user = AuthResponse.fromJson(body);
      return user;
    } else {
      throw RequestException();
    }
  }
}
