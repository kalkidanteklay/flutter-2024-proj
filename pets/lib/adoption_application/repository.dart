import 'package:pets/adoption_application/model.dart';
import 'package:pets/pets/model.dart';

abstract class ApplicationRepository {
  Future<List<Application>> getApplications();
  Future<List<Application>> getAllApplications();
  Future<void> addApplication(Application application);
  Future<void> deleteApplication(String id);
  Future<void> updateApplication(Application application, String id);
}
