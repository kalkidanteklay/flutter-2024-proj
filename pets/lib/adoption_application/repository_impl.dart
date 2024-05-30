import 'package:pets/adoption_application/model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets/adoption_application/repository.dart';
import 'package:pets/adoption_application/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApplicationRepositoryImpl implements ApplicationRepository {
  final ApplicationApiProvider applicationApiProvider;

  ApplicationRepositoryImpl(this.applicationApiProvider);

  @override
  Future<List<Application>> getApplications() async {
    return await applicationApiProvider.fetchApplications();
  }

  @override
  Future<List<Application>> getAllApplications() async {
    return await applicationApiProvider.fetchAllApplications();
  }

  @override
  Future<void> addApplication(Application application) async {
    await applicationApiProvider.addApplication(application);
  }

  @override
  Future<void> deleteApplication(String id) async {
    await applicationApiProvider.deleteApplication(id);
  }

  @override
  Future<void> updateApplication(Application application, String id) async {
    await applicationApiProvider.updateApplication(application, id);
  }
}
