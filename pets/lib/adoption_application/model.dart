class Application {
  final String? id;
  final String? userId;
  //final String? petId;
  final String? fullName;
  final String? address;
  final String? phoneNumber;
  final String? typeOfPet;
  final String? gender;
  final String? ageRange;
  final String? previousPetOwnershipExperience;

  Application({
    this.id,
    this.userId,
    //this.petId,
    this.fullName,
    this.address,
    this.phoneNumber,
    this.typeOfPet,
    this.gender,
    this.ageRange,
    this.previousPetOwnershipExperience,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['_id'],
      userId: json['userId'],
      //petId: json['petId'],
      fullName: json['fullName'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      typeOfPet: json['typeOfPet'],
      gender: json['gender'],
      ageRange: json['ageRange'],
      previousPetOwnershipExperience: json['previousPetOwnershipExperience'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // '_id': id,
      'userId': userId,
      // 'petId': petId,
      'fullName': fullName,
      'address': address,
      'phoneNumber': phoneNumber,
      'typeOfPet': typeOfPet,
      'gender': gender,
      'ageRange': ageRange,
      'previousPetOwnershipExperience': previousPetOwnershipExperience,
    };
  }
}
