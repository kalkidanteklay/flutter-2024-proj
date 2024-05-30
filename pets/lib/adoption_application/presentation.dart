import 'package:flutter/material.dart';
import 'package:pets/adoption_application/provider.dart';
import 'package:pets/adoption_application/model.dart';
import 'package:pets/adoption_application/states.dart';

class ApplicationPage extends StatefulWidget {
  final String userId;
  final String token;

  ApplicationPage({required this.userId, required this.token});

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  final _formKey = GlobalKey<FormState>();

  //final _petIdController = TextEditingController();
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
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    //_petIdController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _typeOfPetController.dispose();
    _genderController.dispose();
    _ageRangeController.dispose();
    _previousPetOwnershipExperienceController.dispose();
    super.dispose();
  }

  void _submitApplication() async {
    if (_formKey.currentState!.validate()) {
      final application = Application(
        userId: widget.userId,
        //petId: _petIdController.text,
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
        await _applicationApiProvider.addApplication(application);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Application submitted successfully')));
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to submit application: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Adopt a Pet',
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
                    // buildTextFormField(
                    //   label: 'Pet Id',
                    //   controller: _petIdController,
                    //   //decoration: InputDecoration(labelText: 'pet id'),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your petid';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    SizedBox(height: 16.0),
                    buildTextFormField(
                      label: 'Full Name',
                      controller: _fullNameController,
                      // decoration: InputDecoration(labelText: 'Full Name'),
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
                      //decoration: InputDecoration(labelText: 'Address'),
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
                      //decoration: InputDecoration(labelText: 'Phone Number'),
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
                      //decoration: InputDecoration(labelText: 'Type of Pet'),
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
                      //decoration: InputDecoration(labelText: 'Gender'),
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
                      //decoration: InputDecoration(labelText: 'Age Range'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the age range';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.0),
                    buildTextFormField(
                      label: 'Previous Pet Ownership Experience', maxLines: 5,
                      controller: _previousPetOwnershipExperienceController,
                      //decoration: InputDecoration(
                      //labelText: 'Previous Pet Ownership Experience'),
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
                      onPressed: _submitApplication,
                      child:
                          Text('Submit', style: TextStyle(color: Colors.black)),
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
