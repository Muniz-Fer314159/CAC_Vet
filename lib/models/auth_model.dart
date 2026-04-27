class AuthResponse {
  final String token;
  final String login;

  AuthResponse({required this.token, required this.login});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String,
      login: json['login'] as String,
    );
  }
}
