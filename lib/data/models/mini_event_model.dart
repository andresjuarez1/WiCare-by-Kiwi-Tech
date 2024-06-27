// lib/data/models/volunteer_model.dart
class MiniEventModel {
  final String name;
  final String associationName;

  MiniEventModel({
    required this.name,
    required this.associationName,
  });

  factory MiniEventModel.fromJson(Map<String, dynamic> json) {
    return MiniEventModel(
      name: json['name'],
      associationName: json['associationName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'associationName': associationName,
    };
  }
}
