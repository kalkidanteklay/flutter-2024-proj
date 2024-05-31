import 'package:pets/pets/model.dart';
import 'package:image_picker/image_picker.dart';

abstract class PetRepository {
  Future<List<Pet>> getPets();
  Future<String> addPet(Pet pet, XFile image);
  Future<void> deletePet(String id);
  Future<void> updatePet(Pet pet);
}
