import 'dart:convert';

import 'package:footloose_app/core/error/exceptions.dart';
import 'package:footloose_app/core/request_builder.dart';
import 'package:footloose_app/core/shared_preferences_key.dart';
import 'package:footloose_app/domain/models/auth_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthDataSource {
  Future<AuthResponse> loginUser(String email, String password);
  Future<bool> saveUser(AuthResponse authResponse);
}

class AuthDataSourceImpl implements AuthDataSource {
  const AuthDataSourceImpl({
    required this.requestBuilder,
    required this.sharedPreferences,
  });

  final RequestBuilder requestBuilder;
  final SharedPreferences sharedPreferences;

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

  @override
  Future<bool> saveUser(AuthResponse authResponse) async {
    await sharedPreferences.setString(
      Preferences.token,
      authResponse.token,
    );
    await sharedPreferences.setString(
      Preferences.userType,
      authResponse.userType,
    );
    await sharedPreferences.setString(
      Preferences.email,
      authResponse.email,
    );
    return true;
  }
}
