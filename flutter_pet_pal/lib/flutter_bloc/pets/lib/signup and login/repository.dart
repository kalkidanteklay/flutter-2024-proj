import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  final String baseUrl;

  UserRepository({required this.baseUrl});

  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      if (json['access_token'] == null) {
        throw Exception('Invalid response from server');
      }
      return json['access_token'];
    } else {
      throw Exception('Invalid credentials');
    }
  }

  Future<void> signup(String email, String password, String fullName) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'fullName': fullName,
      }),
    );

    if (response.statusCode == 201) {
      print("sign up successful");
      // final json = jsonDecode(response.body);
      // return json['_id'];
    } else {
      throw Exception('Failed to sign up');
    }
  }
}
