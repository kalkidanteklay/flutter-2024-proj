import 'package:flutter/material.dart';
import 'package:pets/widgets/new_tiles.dart';
import 'package:pets/pets/pet_bloc.dart';
import 'package:pets/pets/repository.dart';
import 'package:pets/pets/events.dart';
import 'package:pets/pets/states.dart';
import 'package:pets/pets/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/pets/editPetScreen.dart';

class DogsTab extends StatelessWidget {
  final PetRepository petRepository;

  DogsTab({required this.petRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PetBloc>(
          create: (context) => PetBloc(petRepository)..add(GetPetEvent()),
        ),
      ],
      child: blocBody(),
    );
  }

  Widget blocBody() {
    return BlocBuilder<PetBloc, PetState>(
      builder: (context, state) {
        if (state is PetLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetPetsLoadedState) {
          List<Pet> pets = state.pets;
          return GridView.builder(
            padding: EdgeInsets.all(12),
            itemCount: pets.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.5),
            itemBuilder: (context, index) {
              final pet = pets[index];
              return AllTile(
                name: pet.name ?? 'Unknown',
                age: pet.age?.toString() ?? 'Unknown',
                gender: pet.gender ?? 'Unknown',
                species: pet.species ?? 'Unknown',
                image: pet.image ?? 'Unknown',
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPetScreen(pet: pet),
                    ),
                  );
                },
                onDelete: () {
                  BlocProvider.of<PetBloc>(context)
                      .add(DeletePetEvent(pet.id!));
                },
              );
            },
          );
        } else if (state is GetPetErrorState) {
          return Center(
            child: Text("Error: ${state.message}"),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
