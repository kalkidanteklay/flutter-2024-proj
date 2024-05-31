class Pet {
  final String id;
  final String? name;
  final int? age;
  final String? gender;
  final String? species;
  final String? category;
  final String? image;

  Pet({
    required this.id,
    this.name,
    this.age,
    this.gender,
    this.species,
    this.category,
    this.image,
  });
  Pet copyWith({
    String? id,
    String? name,
    int? age,
    String? species,
    String? gender,
    String? description,
    String? image,
    String? category,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      species: species ?? this.species,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      category: category ?? this.category,
    );
  }

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['_id'] ?? '',
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      species: json['species'],
      category: json['category'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'species': species,
      'category': category,
      'image': image,
    };
  }
}
