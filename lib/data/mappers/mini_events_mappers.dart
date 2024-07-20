import '../../domain/entities/miniEvent.dart';
import '../models/mini_event_model.dart';

MiniEvent miniEventModelToMiniEvent(MiniEventModel model) {
  return MiniEvent(
    name: model.name,
    description: model.description,
    hour_start: model.hour_start,
    id: model.id,
  );
}

MiniEventModel miniEventToMiniEventModel(MiniEvent entity) {
  return MiniEventModel(
    name: entity.name,
    description: entity.description,
    hour_start: entity.hour_start,
    id: entity.id,
  );
}
