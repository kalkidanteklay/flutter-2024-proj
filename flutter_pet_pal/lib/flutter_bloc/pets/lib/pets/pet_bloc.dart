import 'package:http/http.dart' as http;
import 'package:pets/pets/model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets/pets/repository.dart';
import 'package:pets/pets/states.dart';
import 'package:pets/pets/events.dart';
import 'package:pets/pets/repository impl.dart';
import 'package:bloc/bloc.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  final PetRepository petRepository;

  PetBloc(this.petRepository) : super(PetInitial()) {
    on<LoadPetsEvent>((event, emit) async {
      emit(PetLoading());
      try {
        final pets = await petRepository.getPets();
        emit(GetPetsLoadedState(pets));
      } catch (e) {
        emit(PetError('Failed to load pets'));
      }
    });

    on<AddPetEvent>((event, emit) async {
      try {
        final petId = await petRepository.addPet(
          event.pet,
          event.image,
        );
        emit(PetAddedSuccess(petId));
      } catch (e) {
        emit(PetError('Failed to add pet'));
      }
    });
    on<GetPetEvent>((event, emit) async {
      emit(PetLoading());
      try {
        final pets = await petRepository.getPets();
        emit(GetPetsLoadedState(pets));
      } catch (e) {
        emit(GetPetErrorState('Failed to load pets'));
      }
    });

    on<UpdatePetEvent>((event, emit) async {
      try {
        await petRepository.updatePet(event.pet);
        emit(PetUpdatedSuccess());
      } catch (e) {
        emit(PetError('Failed to update pet'));
      }
    });

    on<DeletePetEvent>((event, emit) async {
      try {
        await petRepository.deletePet(event.petId);
        add(LoadPetsEvent());
      } catch (e) {
        emit(PetError('Failed to delete pet'));
      }
    });
  }
}
