import '../../domain/entities/association.dart';
import '../models/association_model.dart';

AssociationModel associationToAssociationModel(Association association) {
  return AssociationModel(
    name: association.name,
    foundation_date: association.foundation_date,
    email: association.email,
    password: association.password,
    position: association.position,
    age: association.age,
    name_manager: association.name_manager,
    cellphone_manager: association.cellphone_manager,
    latitude_manager: association.latitude_manager,
    longitude_manager: association.longitude_manager,
    genre: association.genre,
    latitude: association.latitude,
    longitude: association.longitude,
    social_reason: association.social_reason,
    description: association.description,
    RFC: association.RFC,
    cellphone: association.cellphone,
  );
}

Association associationModelToAssociation(AssociationModel model) {
  return Association(
    name: model.name,
    foundation_date: model.foundation_date,
    email: model.email,
    password: model.password,
    position: model.position,
    age: model.age,
    name_manager: model.name_manager,
    cellphone_manager: model.cellphone_manager,
    latitude_manager: model.latitude_manager,
    longitude_manager: model.longitude_manager,
    genre: model.genre,
    latitude: model.latitude,
    longitude: model.longitude,
    social_reason: model.social_reason,
    description: model.description,
    RFC: model.RFC,
    cellphone: model.cellphone,
  );
}
