class MiniEventModel {
  final String name;
  final String description;
  final String hour_start;
  final int id;

  MiniEventModel({
    required this.name,
    required this.description,
    required this.hour_start,
    required this.id,
  });

  factory MiniEventModel.fromJson(Map<String, dynamic> json) {
    return MiniEventModel(
      name: json['name'],
      description: json['description'],
      hour_start: json['hour_start'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'hour_start': hour_start,
      'id': id,
    };
  }
}
