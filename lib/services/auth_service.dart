import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _authBaseUrl = 'https://mobile-ios-login.zani0x03.eti.br/api';
  static const String _iaBaseUrl = 'https://mobile-ios-ia.zani0x03.eti.br/api';
  
  static const String _sistemaId = 'e29f685c-ffd3-4adb-97cc-cf6bb652ed12';

  Future<Map<String, dynamic>> register({
    required String name,
    required String surname,
    required String login,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$_authBaseUrl/register');
    
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'surname': surname,
        'login': login,
        'email': email,
        'password': password,
        'sistemaId': _sistemaId,
      }),
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('$_authBaseUrl/auth/login');
    
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'sistemaId': _sistemaId,
      }),
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> chatIA({
    required String prompt,
    required String token,
  }) async {
    final url = Uri.parse('$_iaBaseUrl/ai/chat');

    const String prePrompt = '''
Você é um assistente virtual especializado para funcionários de uma clínica veterinária. 
Seu objetivo é ajudar com dúvidas sobre rotinas da clínica, triagem de pacientes, cuidados básicos com animais, medicamentos e protocolos internos. 
Responda de forma profissional, objetiva e empática. 
Pergunta do funcionário: ''';

    final String finalPrompt = '$prePrompt$prompt';
    
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'prompt': finalPrompt,
      }),
    );

    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body);
      }
      return {}; 
    } else {
      throw Exception('Erro na requisição: ${response.statusCode} - ${response.body}');
    }
  }
}