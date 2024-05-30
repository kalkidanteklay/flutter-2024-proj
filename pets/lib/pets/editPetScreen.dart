import 'package:flutter/material.dart';
import 'package:pets/pets/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/pets/pet_bloc.dart';
import 'package:pets/pets/states.dart';
import 'package:pets/pets/provider.dart';
import 'package:pets/pets/events.dart';
import 'package:pets/pets/repository impl.dart';

class EditPetScreen extends StatelessWidget {
  final Pet pet;

  EditPetScreen({required this.pet});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController(text: pet.name);
    final _ageController = TextEditingController(text: pet.age.toString());
    final _genderController = TextEditingController(text: pet.gender);
    final _speciesController = TextEditingController(text: pet.species);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildTextFormField(
                label: 'Name',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              buildTextFormField(
                label: 'Age',
                controller: _ageController,
                inputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              buildTextFormField(
                label: 'Gender',
                controller: _genderController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a gender';
                  }
                  return null;
                },
              ),
              buildTextFormField(
                label: 'Species',
                controller: _speciesController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a species';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    // Dispatch UpdatePetEvent with updated pet details
                    final updatedPet = Pet(
                      id: pet.id, // Preserve the original ID
                      name: _nameController.text,
                      age: int.parse(_ageController.text),
                      gender: _genderController.text,
                      species: _speciesController.text,
                    );
                    // BlocProvider.of<PetBloc>(context).add(UpdatePetEvent(pet.id, updatedPet));
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int maxLines = 1,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: inputType,
      maxLines: maxLines,
      validator: validator,
    );
  }
}
