class EventModel {
  final String name;
  final String description;
  final String hour_start;
  final String hour_end;// Hora en formato HH:mm
  final String date; // Fecha en formato yyyy-MM-dd
  final String cathegory; // Categoría del evento
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

  // Método para convertir el evento a un mapa (JSON) que se puede enviar a la API
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
}
