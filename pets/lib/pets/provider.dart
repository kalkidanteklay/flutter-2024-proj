import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pets/pets/model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class PetApiProvider {
  final String baseUrl;
  final String token;

  PetApiProvider(this.baseUrl, this.token);

  Future<List<Pet>> fetchPets() async {
    final response = await http.get(
      Uri.parse('$baseUrl/pets'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Pet.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pets');
    }
  }

  Future<String> addPet(Pet pet, XFile image) async {
    final uri = Uri.parse('$baseUrl/pets');
    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = pet.name!;
    request.fields['species'] = pet.species!;
    request.fields['age'] = pet.age.toString();
    request.fields['gender'] = pet.gender!;
    request.fields['category'] = pet.category!;

    // Logging request fields
    print('Request fields: ${request.fields}');

    try {
      if (!kIsWeb) {
        // For mobile and desktop
        request.files
            .add(await http.MultipartFile.fromPath('image', image.path));
      } else {
        // For web
        var byteData = await image.readAsBytes();
        var imageFile = http.MultipartFile.fromBytes(
          'image',
          byteData,
          filename: image.name,
        );
        request.files.add(imageFile);
      }
    } catch (e) {
      print('Error adding image to request: $e');
      throw Exception('Failed to add image to request');
    }

    // Logging request files
    print('Request files: ${request.files}');

    request.headers['Authorization'] = 'Bearer $token';

    // Logging request headers
    print('Request headers: ${request.headers}');

    try {
      var response = await request.send();

      // Logging response status code
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();

        var jsonResponse = json.decode(responseBody);
        return jsonResponse['id'];
      } else {
        var responseBody = await response.stream.bytesToString();

        // Logging error response body
        print('Error response body: $responseBody');

        throw Exception('Failed to add pet');
      }
    } catch (e) {
      print('Error sending request: $e');
      throw Exception('Failed to send request');
    }
  }

  Future<void> deletePet(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/pets/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete pet');
    }
  }

  Future<void> updatePet(Pet pet) async {
    final url = Uri.parse('$baseUrl/pets/id');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final body = json.encode(pet.toJson());

    // Logging request details
    print('PATCH Request URL: $url');
    print('PATCH Request Headers: $headers');
    print('PATCH Request Body: $body');

    final response = await http.patch(
      url,
      headers: headers,
      body: body,
    );

    // Logging response details
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to update pet');
    }
  }
}
