import 'package:pets/pets/model.dart';
import 'package:test/test.dart';

void main() {
  group('Pet', () {
    test('copyWith returns a copy with updated values', () {
      final pet = Pet(
        id: '1',
        name: 'Fluffy',
        age: 3,
        gender: 'Female',
        species: 'Cat',
        category: 'Mammal',
        image: 'image.png',
      );

      final updatedPet = pet.copyWith(
        name: 'Mittens',
        age: 4,
      );

      expect(updatedPet.id, '1');
      expect(updatedPet.name, 'Mittens');
      expect(updatedPet.age, 4);
      expect(updatedPet.gender, 'Female');
      expect(updatedPet.species, 'Cat');
      expect(updatedPet.category, 'Mammal');
      expect(updatedPet.image, 'image.png');
    });

    test('fromJson creates a Pet instance from a JSON object', () {
      final json = {
        '_id': '1',
        'name': 'Fluffy',
        'age': 3,
        'gender': 'Female',
        'species': 'Cat',
        'category': 'Mammal',
        'image': 'image.png',
      };

      final pet = Pet.fromJson(json);

      expect(pet.id, '1');
      expect(pet.name, 'Fluffy');
      expect(pet.age, 3);
      expect(pet.gender, 'Female');
      expect(pet.species, 'Cat');
      expect(pet.category, 'Mammal');
      expect(pet.image, 'image.png');
    });

    test('toJson converts a Pet instance to a JSON object', () {
      final pet = Pet(
        id: '1',
        name: 'Fluffy',
        age: 3,
        gender: 'Female',
        species: 'Cat',
        category: 'Mammal',
        image: 'image.png',
      );

      final json = pet.toJson();

      expect(json['_id'], '1');
      expect(json['name'], 'Fluffy');
      expect(json['age'], 3);
      expect(json['gender'], 'Female');
      expect(json['species'], 'Cat');
      expect(json['category'], 'Mammal');
      expect(json['image'], 'image.png');
    });

    test('copyWith with no arguments returns the same Pet', () {
      final pet = Pet(
        id: '1',
        name: 'Fluffy',
        age: 3,
        gender: 'Female',
        species: 'Cat',
        category: 'Mammal',
        image: 'image.png',
      );

      final samePet = pet.copyWith();

      expect(samePet.id, pet.id);
      expect(samePet.name, pet.name);
      expect(samePet.age, pet.age);
      expect(samePet.gender, pet.gender);
      expect(samePet.species, pet.species);
      expect(samePet.category, pet.category);
      expect(samePet.image, pet.image);
    });
  });
}
