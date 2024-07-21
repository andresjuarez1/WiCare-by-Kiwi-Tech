class MiniEventModel {
  final String name;
  final String description;
  final String hour_start;
  final int id;
  final String picture;

  MiniEventModel({
    required this.name,
    required this.description,
    required this.hour_start,
    required this.id,
    required this.picture
  });

  factory MiniEventModel.fromJson(Map<String, dynamic> json) {
    return MiniEventModel(
      name: json['name'],
      description: json['description'],
      hour_start: json['hour_start'],
      id: json['id'],
      picture: json['picture']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'hour_start': hour_start,
      'id': id,
      'picture': picture,
    };
  }
}
