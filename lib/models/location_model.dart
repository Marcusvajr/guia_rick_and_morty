class LocationModel {
  const LocationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
  });

  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;

  String get localizedType {
    switch (type.toLowerCase()) {
      case 'planet':
        return 'Planeta';
      case 'cluster':
        return 'Aglomerado';
      case 'space station':
        return 'Estação espacial';
      case 'microverse':
        return 'Microverso';
      case 'tv':
        return 'TV';
      case 'resort':
        return 'Resort';
      case 'fantasy town':
        return 'Cidade fantasia';
      case 'dream':
        return 'Sonho';
      case 'dimension':
        return 'Dimensão';
      case 'unknown':
        return 'Desconhecido';
      default:
        return type.isEmpty ? 'Desconhecido' : type;
    }
  }

  String get localizedDimension {
    if (dimension.toLowerCase() == 'unknown' || dimension.isEmpty) {
      return 'Desconhecida';
    }
    return dimension;
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
      dimension: json['dimension'] as String? ?? '',
      residents: List<String>.from(json['residents'] as List? ?? const []),
    );
  }
}
