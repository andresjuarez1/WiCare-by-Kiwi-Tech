class EventUnique {
  final int id;
  final String name;
  final String description;
  final double latitude;
  final double? longitude;
  final String hour_start;
  final String? hour_end;
  final String date;
  final String cathegory;
  final String picture;
  final int association_id;

  EventUnique({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.hour_start,
    this.hour_end,
    required this.date,
    required this.cathegory,
    this.picture = '',
    this.association_id = 0,
  });

  factory EventUnique.fromJson(Map<String, dynamic> json) {
    print('Received JSON: $json'); // Agrega esta línea para depuración
    return EventUnique(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
      hour_start: json['hour_start'],
      hour_end: json['hour_end'],
      date: json['date'],
      cathegory: json['cathegory'],
      picture: json['picture'],
      association_id: json['association_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'hour_start': hour_start,
      'hour_end': hour_end,
      'date': date,
      'cathegory': cathegory,
      'picture': picture,
      'association_id': association_id,
    };
  }
}
