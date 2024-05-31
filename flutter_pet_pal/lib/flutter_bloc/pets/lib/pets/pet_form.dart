import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/pets/pet_bloc.dart';
import 'package:pets/pets/provider.dart';
import 'package:pets/pets/states.dart';
import 'package:pets/pets/events.dart';
import 'package:pets/pets/repository.dart';
import 'package:pets/pets/repository impl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:pets/pets/model.dart';
import 'dart:io';

class PetFormWidget extends StatefulWidget {
  final String token;
  final Pet? pet;
  const PetFormWidget({required this.token, this.pet});

  @override
  _PetFormWidgetState createState() => _PetFormWidgetState();
}

class _PetFormWidgetState extends State<PetFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _speciesController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _categoryController = TextEditingController();
  XFile? _selectedImage;

  @override
  void dispose() {
    _nameController.dispose();
    _speciesController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text('Add New Pet'),
        centerTitle: true,
      ),
      body: BlocListener<PetBloc, PetState>(
        listener: (context, state) {
          if (state is PetAddedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Pet added successfully!')),
            );
            Navigator.of(context).pop();
          } else if (state is PetError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
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
                    label: 'Species',
                    controller: _speciesController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a breed';
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
                  // SizedBox(height: 20),
                  buildTextFormField(
                    label: 'category',
                    controller: _categoryController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a category';
                      }
                      return null;
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_a_photo_rounded,
                      color: Colors.grey[800],
                      size: 28,
                    ),
                    onPressed: _pickImage,
                  ),
                  if (_selectedImage != null)
                    kIsWeb
                        ? Image.network(_selectedImage!.path, height: 150)
                        : Image.file(File(_selectedImage!.path), height: 150),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        final pet = Pet(
                          id: widget.pet?.id ?? '',
                          name: _nameController.text,
                          species: _speciesController.text,
                          age: int.parse(_ageController.text),
                          gender: _genderController.text,
                          category: _categoryController.text,
                          image: _selectedImage?.path, // Set the image URL
                        );
                        BlocProvider.of<PetBloc>(context)
                            .add(AddPetEvent(pet, _selectedImage!));
                      }
                      Navigator.pop(context);
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildTextFormField({
  required String label,
  required TextEditingController controller,
  required String? Function(String?)? validator,
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
