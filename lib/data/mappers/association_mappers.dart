
import '../../domain/entities/association.dart';
import '../models/association_model.dart';

AssociationModel associationToAssociationModel(Association association) {
  return AssociationModel(
    name : association.name,
    foundation_date : association.foundation_date,
    email : association.email,
    password :association.password,
    position : association.position,
    age : association.age,
    name_manager : association.name_manager,
    cellphone_manager : association.cellphone_manager,
    address_manager : association.address_manager,
    genre : association.genre,
    address : association.address,
    social_reason : association.social_reason,
    description : association.description,
    cellphone : association.cellphone,
    RFC: association.RFC,

  );
}

Association associationModelToAssociation(AssociationModel model) {
  return Association(
    name: model.name,
    address: model.address,
    foundation_date: model.foundation_date,
    position: model.position,

    social_reason: model.social_reason,
    description: model.description,
    cellphone: model.cellphone,
    RFC: model.RFC,

    name_manager: model.name_manager,
    age: model.age,
    genre: model.genre,
    cellphone_manager: model.cellphone_manager,
    address_manager: model.address_manager,

    email: model.email,
    password: model.password,
  );
}
