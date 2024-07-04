// mappers/mini_event_mapper.dart
import '../../domain/entities/miniEvent.dart';

import '../models/mini_event_model.dart';

MiniEvent miniEventModelToMiniEvent(MiniEventModel model) {
  return MiniEvent(
    name: model.name,
    associationName: model.associationName,
  );
}

MiniEventModel miniEventToMiniEventModel(MiniEvent entity) {
  return MiniEventModel(
    name: entity.name,
    associationName: entity.associationName,
  );
}
