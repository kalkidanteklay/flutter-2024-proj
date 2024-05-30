import 'package:pets/adoption_application/model.dart';
import 'package:test/test.dart';

void main() {
  group('Application', () {
    test('fromJson creates an Application instance from a JSON object', () {
      final json = {
        '_id': '123',
        'userId': 'user_456',
        'fullName': 'John Doe',
        'address': '123 Main St',
        'phoneNumber': '555-1234',
        'typeOfPet': 'Dog',
        'gender': 'Male',
        'ageRange': '30-40',
        'previousPetOwnershipExperience': 'Yes',
      };

      final application = Application.fromJson(json);

      expect(application.id, '123');
      expect(application.userId, 'user_456');
      expect(application.fullName, 'John Doe');
      expect(application.address, '123 Main St');
      expect(application.phoneNumber, '555-1234');
      expect(application.typeOfPet, 'Dog');
      expect(application.gender, 'Male');
      expect(application.ageRange, '30-40');
      expect(application.previousPetOwnershipExperience, 'Yes');
    });

    test('toJson converts an Application instance to a JSON object', () {
      final application = Application(
        id: '123',
        userId: 'user_456',
        fullName: 'John Doe',
        address: '123 Main St',
        phoneNumber: '555-1234',
        typeOfPet: 'Dog',
        gender: 'Male',
        ageRange: '30-40',
        previousPetOwnershipExperience: 'Yes',
      );

      final json = application.toJson();

      expect(json['_id'], isNull); // Since '_id' is not included in toJson
      expect(json['userId'], 'user_456');
      expect(json['fullName'], 'John Doe');
      expect(json['address'], '123 Main St');
      expect(json['phoneNumber'], '555-1234');
      expect(json['typeOfPet'], 'Dog');
      expect(json['gender'], 'Male');
      expect(json['ageRange'], '30-40');
      expect(json['previousPetOwnershipExperience'], 'Yes');
    });

    test('Application properties are correctly assigned', () {
      final application = Application(
        id: '123',
        userId: 'user_456',
        fullName: 'John Doe',
        address: '123 Main St',
        phoneNumber: '555-1234',
        typeOfPet: 'Dog',
        gender: 'Male',
        ageRange: '30-40',
        previousPetOwnershipExperience: 'Yes',
      );

      expect(application.id, '123');
      expect(application.userId, 'user_456');
      expect(application.fullName, 'John Doe');
      expect(application.address, '123 Main St');
      expect(application.phoneNumber, '555-1234');
      expect(application.typeOfPet, 'Dog');
      expect(application.gender, 'Male');
      expect(application.ageRange, '30-40');
      expect(application.previousPetOwnershipExperience, 'Yes');
    });

    test('fromJson handles missing fields gracefully', () {
      final json = {
        '_id': '123',
        'userId': 'user_456',
        // 'fullName': 'John Doe', // Missing field
        'address': '123 Main St',
        'phoneNumber': '555-1234',
        'typeOfPet': 'Dog',
        'gender': 'Male',
        'ageRange': '30-40',
        'previousPetOwnershipExperience': 'Yes',
      };

      final application = Application.fromJson(json);

      expect(application.id, '123');
      expect(application.userId, 'user_456');
      expect(application.fullName, isNull); // Missing field should be null
      expect(application.address, '123 Main St');
      expect(application.phoneNumber, '555-1234');
      expect(application.typeOfPet, 'Dog');
      expect(application.gender, 'Male');
      expect(application.ageRange, '30-40');
      expect(application.previousPetOwnershipExperience, 'Yes');
    });
  });
}
