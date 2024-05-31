import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pets/adoption_application/model.dart';

class ApplicationApiProvider {
  final String baseUrl;
  final String token;

  ApplicationApiProvider(this.baseUrl, this.token);

  Future<List<Application>> fetchApplications() async {
    final response = await http.get(
      Uri.parse('$baseUrl/adoption-applications/me'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Application.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load applications');
    }
  }

  Future<List<Application>> fetchAllApplications() async {
    final response = await http.get(
      Uri.parse('$baseUrl/adoption-applications'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Application.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load applications');
    }
  }

  Future<void> addApplication(Application application) async {
    final uri = Uri.parse('$baseUrl/adoption-applications');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(application.toJson()),
    );

    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      print('Application added successfully');
    } else {
      throw Exception('Failed to add application: ${response.reasonPhrase}');
    }
  }

  Future<void> deleteApplication(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/adoption-applications/me/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete application');
    }
  }

  Future<void> updateApplication(Application application) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/pets/${application.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(application.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update application');
    }
  }
}
