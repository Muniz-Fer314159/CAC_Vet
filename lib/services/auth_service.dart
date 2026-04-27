import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_model.dart';

class AuthService {
  // Chave usada para salvar o token no SharedPreferences
  static const _tokenKey = 'auth_token';

  // ─────────────────────────────────────────────
  // MOCK: usuários válidos (substitua pela API real do professor depois)
  // ─────────────────────────────────────────────
  static const _mockUsers = [
    {'login': 'admin', 'senha': '1234'},
    {'login': 'usuario', 'senha': '1234'},
  ];

  // ─────────────────────────────────────────────
  // Gera um JWT falso (apenas para mock)
  // Quando usar a API real do professor, este método some —
  // o token virá direto da resposta HTTP.
  // ─────────────────────────────────────────────
  static String _gerarTokenMock(String login) {
    // Header e payload em Base64 (não é criptografado — só mock!)
    final header = base64Url.encode(utf8.encode('{"alg":"HS256","typ":"JWT"}'));
    final payload = base64Url.encode(
      utf8.encode('{"sub":"$login","iat":${DateTime.now().millisecondsSinceEpoch ~/ 1000}}'),
    );
    const signature = 'assinatura_mock'; // mock — não use em produção!
    return '$header.$payload.$signature';
  }

  // ─────────────────────────────────────────────
  // Login: valida credenciais e salva o token
  // Retorna AuthResponse em caso de sucesso,
  // lança Exception em caso de erro.
  // ─────────────────────────────────────────────
  Future<AuthResponse> login(String login, String senha) async {
    // Simula delay de rede (retire ao usar API real)
    await Future.delayed(const Duration(milliseconds: 600));

    final usuarioValido = _mockUsers.any(
      (u) => u['login'] == login && u['senha'] == senha,
    );

    if (!usuarioValido) {
      throw Exception('Login ou senha inválidos.');
    }

    final token = _gerarTokenMock(login);
    final response = AuthResponse(token: token, login: login);

    // Salva o token localmente
    await _salvarToken(token);

    return response;
  }

  // ─────────────────────────────────────────────
  // Salva o token no SharedPreferences
  // ─────────────────────────────────────────────
  Future<void> _salvarToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // ─────────────────────────────────────────────
  // Recupera o token salvo (útil para requisições futuras)
  // ─────────────────────────────────────────────
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // ─────────────────────────────────────────────
  // Logout: remove o token salvo
  // ─────────────────────────────────────────────
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // ─────────────────────────────────────────────
  // Verifica se o usuário está logado
  // ─────────────────────────────────────────────
  Future<bool> isLogado() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
