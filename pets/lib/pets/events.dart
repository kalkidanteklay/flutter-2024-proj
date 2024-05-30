import 'package:equatable/equatable.dart';
import 'package:pets/pets/model.dart';
import 'package:image_picker/image_picker.dart';

abstract class PetEvent extends Equatable {
  const PetEvent();

  @override
  List<Object> get props => [];
}

class LoadPetsEvent extends PetEvent {}

class AddPetEvent extends PetEvent {
  final Pet pet;
  final XFile image;

  const AddPetEvent(this.pet, this.image);

  @override
  List<Object> get props => [pet, image];
}

class GetPetEvent extends PetEvent {
  @override
  List<Object> get props => [];
}

class UpdatePetEvent extends PetEvent {
  //final String petId;
  final Pet pet;

  UpdatePetEvent(this.pet);

  @override
  List<Object> get props => [pet];
}

class DeletePetEvent extends PetEvent {
  final String petId;

  const DeletePetEvent(this.petId);

  @override
  List<Object> get props => [petId];
}
