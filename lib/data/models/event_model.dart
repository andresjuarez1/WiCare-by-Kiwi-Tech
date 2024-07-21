class EventModel {
  final String name;
  final String description;
  final String hour_start;
  final String hour_end;
  final String date;
  final String cathegory;
  final String picture;

  EventModel({
    required this.name,
    required this.description,
    required this.hour_start,
    required this.hour_end,
    required this.date,
    required this.cathegory,
    this.picture = '',
  });

  // Método toJson para convertir la instancia a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'hour_start': hour_start,
      'hour_end': hour_end,
      'date': date,
      'cathegory': cathegory,

      'picture': picture,
    };
  }

  // Método fromJson para crear una instancia a partir de un mapa JSON
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      name: json['name'],
      description: json['description'],
      hour_start: json['hour_start'],
      hour_end: json['hour_end'],
      date: json['date'],
      cathegory: json['cathegory'],

      picture: json['picture'] ?? '',
    );
  }
}