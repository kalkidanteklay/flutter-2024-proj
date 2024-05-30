import 'package:flutter/material.dart';
import 'package:pets/adoption_application/provider.dart';
import 'package:pets/adoption_application/model.dart';
import 'package:pets/adoption_application/states.dart';

class EditPage extends StatefulWidget {
  final String userId;
  final String token;
  final Application application;

  EditPage(
      {required this.userId, required this.token, required this.application});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _typeOfPetController = TextEditingController();
  final _genderController = TextEditingController();
  final _ageRangeController = TextEditingController();
  final _previousPetOwnershipExperienceController = TextEditingController();

  late ApplicationApiProvider _applicationApiProvider;

  @override
  void initState() {
    super.initState();
    _applicationApiProvider =
        ApplicationApiProvider('http://localhost:3000', widget.token);

    _fullNameController.text = widget.application.fullName ?? '';
    _addressController.text = widget.application.address ?? '';
    _phoneNumberController.text = widget.application.phoneNumber ?? '';
    _typeOfPetController.text = widget.application.typeOfPet ?? '';
    _genderController.text = widget.application.gender ?? '';
    _ageRangeController.text = widget.application.ageRange ?? '';
    _previousPetOwnershipExperienceController.text =
        widget.application.previousPetOwnershipExperience ?? '';
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _typeOfPetController.dispose();
    _genderController.dispose();
    _ageRangeController.dispose();
    _previousPetOwnershipExperienceController.dispose();
    super.dispose();
  }

  void _editApplication() async {
    if (_formKey.currentState!.validate()) {
      final application = Application(
        id: widget.application.id,
        userId: widget.userId,
        fullName: _fullNameController.text,
        address: _addressController.text,
        phoneNumber: _phoneNumberController.text,
        typeOfPet: _typeOfPetController.text,
        gender: _genderController.text,
        ageRange: _ageRangeController.text,
        previousPetOwnershipExperience:
            _previousPetOwnershipExperienceController.text,
      );

      try {
        await _applicationApiProvider.updateApplication(
            application, application.id!);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Application edited successfully')));
        Navigator.of(context).pop('updated');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update application: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Edit The Application',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.orange[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 16.0),
                    buildTextFormField(
                      label: 'Full Name',
                      controller: _fullNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    buildTextFormField(
                      label: 'Address',
                      controller: _addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    buildTextFormField(
                      label: 'Phone Number',
                      controller: _phoneNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    buildDropdownField(
                      label: 'Type of Pet',
                      items: ['Dog', 'Cat', 'Rabbit', 'Other'],
                      controller: _typeOfPetController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the type of pet';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    buildDropdownField(
                      label: 'Gender',
                      items: ['Male', 'Female', 'Any'],
                      controller: _genderController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the gender';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    buildTextFormField(
                      label: 'Age Range',
                      controller: _ageRangeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the age range';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.0),
                    buildTextFormField(
                      label: 'Previous Pet Ownership Experience',
                      maxLines: 5,
                      controller: _previousPetOwnershipExperienceController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your previous pet ownership experience';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[400],
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      onPressed: _editApplication,
                      child:
                          Text('Update', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget buildDropdownField({
    required String label,
    required List<String> items,
    required TextEditingController controller,
    required FormFieldValidator<String?> validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        value: controller.text.isNotEmpty ? controller.text : null,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {
          controller.text = value ?? '';
        },
        validator: validator,
      ),
    );
  }
}
