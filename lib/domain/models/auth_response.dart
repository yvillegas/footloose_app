class AuthResponse {
  AuthResponse({
    required this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        token: json['token'] as String,
      );

  String token;

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}
