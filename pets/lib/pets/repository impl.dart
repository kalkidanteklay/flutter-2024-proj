import 'package:http/http.dart' as http;
import 'package:pets/pets/model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets/pets/repository.dart';
import 'package:pets/pets/provider.dart';

class PetRepositoryImpl implements PetRepository {
  final PetApiProvider petApiProvider;

  PetRepositoryImpl(this.petApiProvider);

  @override
  Future<List<Pet>> getPets() async {
    return await petApiProvider.fetchPets();
  }

  @override
  Future<String> addPet(Pet pet, XFile image) async {
    return await petApiProvider.addPet(pet, image);
  }

  @override
  Future<void> deletePet(String id) async {
    await petApiProvider.deletePet(id);
  }

  @override
  Future<void> updatePet(Pet pet) async {
    await petApiProvider.updatePet(pet);
  }
}
