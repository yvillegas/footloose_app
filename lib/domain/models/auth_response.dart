class AuthResponse {
  AuthResponse({
    required this.token,
    required this.userType,
    required this.email,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>;
    return AuthResponse(
      token: json['token'] as String,
      userType: user['user_type'] as String,
      email: user['email'] as String,
    );
  }

  String token;
  String userType;
  String email;
}
