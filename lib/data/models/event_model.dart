class EventModel {
  final String name;
  final String description;
  final String hour; // Hora en formato HH:mm
  final String date; // Fecha en formato yyyy-MM-dd
  final String cathegory; // Categoría del evento
  final String location;

  EventModel({
    required this.name,
    required this.description,
    required this.hour,
    required this.date,
    required this.cathegory,
    required this.location,
  });

  // Método para convertir el evento a un mapa (JSON) que se puede enviar a la API
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'hour': hour,
      'date': date,
      'cathegory': cathegory,
      'location': location,
    };
  }
}
