
import '../../domain/entities/event.dart';
import '../models/event_model.dart';

EventModel eventToEventModel(Event event) {
  return EventModel(
    name: event.name,
    description: event.description,
    hour: event.hour,
    date: event.date,
    cathegory: event.cathegory,
    location: event.location,
  );
}

Event eventModelToEvent(EventModel model) {
  return Event(
    name: model.name,
    description: model.description,
    hour: model.hour,
    date: model.date,
    cathegory: model.cathegory,
    location: model.location,

  );
}
