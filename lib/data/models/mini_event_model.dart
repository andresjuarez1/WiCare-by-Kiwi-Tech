class MiniEventModel {
  final String name;
  final String associationName;

  MiniEventModel({
    required this.name,
    required this.associationName,
  });

  // Método factory para crear una instancia a partir de un JSON
  factory MiniEventModel.fromJson(Map<String, dynamic> json) {
    return MiniEventModel(
      name: json['name'],
      associationName: json['association']['name'],
    );
  }

  // Método para convertir el modelo a JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'associationName': associationName,
    };
  }
}
