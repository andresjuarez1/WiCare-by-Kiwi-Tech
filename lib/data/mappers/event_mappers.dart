import '../../domain/entities/event.dart';
import '../models/event_model.dart';

EventModel eventToEventModel(Event event) {
  return EventModel(
    name: event.name,
    description: event.description,
    hour_start: event.hour_start, // Asumiendo que 'hour' en Event corresponde a 'hour_start' en EventModel
    hour_end: event.hour_end, // Puedes dejarlo vacío o ajustarlo según necesites
    date: event.date,
    cathegory: event.cathegory,
    location: event.location,
    picture: event.picture, // Nuevo campo añadido para la imagen
  );
}

Event eventModelToEvent(EventModel model) {
  return Event(
    name: model.name,
    description: model.description,
    hour_start: model.hour_start,
    hour_end: model.hour_end,// Asumiendo que 'hour_start' en EventModel corresponde a 'hour' en Event
    date: model.date,
    cathegory: model.cathegory,
    location: model.location,
    picture: model.picture, // Nuevo campo añadido para la imagen
  );
}
