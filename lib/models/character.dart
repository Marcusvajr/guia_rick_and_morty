class Character {
  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.origin,
    required this.location,
  });

  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final String origin;
  final String location;

  String get localizedStatus {
    switch (status.toLowerCase()) {
      case 'alive':
        return 'Vivo';
      case 'dead':
        return 'Morto';
      default:
        return 'Desconhecido';
    }
  }

  String get localizedGender {
    switch (gender.toLowerCase()) {
      case 'female':
        return 'Feminino';
      case 'male':
        return 'Masculino';
      case 'genderless':
        return 'Sem gênero';
      default:
        return 'Desconhecido';
    }
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      status: json['status'] as String? ?? '',
      species: json['species'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      image: json['image'] as String? ?? '',
      origin: (json['origin'] as Map<String, dynamic>?)?['name'] as String? ?? '',
      location:
          (json['location'] as Map<String, dynamic>?)?['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'gender': gender,
      'image': image,
      'origin': {'name': origin},
      'location': {'name': location},
    };
  }
}
