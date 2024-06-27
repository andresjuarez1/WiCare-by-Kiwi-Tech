
import 'package:locura1/data/models/mini_event_model.dart';
import '../../domain/entities/miniEvent.dart';


// Convierte un objeto Profile a ProfileModel
MiniEventModel miniEventToMiniEventModel(Minievent profile) {
  return MiniEventModel(
    name: profile.name,
    associationName: profile.associationName,
  );
}

// Convierte un objeto ProfileModel a Profile
Minievent MiniEventToMiniEvent(MiniEventModel profileModel) {
  return Minievent(
    name: profileModel.name,
    associationName: profileModel.associationName,

  );
}
