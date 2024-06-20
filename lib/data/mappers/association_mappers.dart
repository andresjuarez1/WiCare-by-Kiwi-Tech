
import '../../domain/entities/association.dart';
import '../models/association_model.dart';

AssociationModel associationToAssociationModel(Association association) {
  return AssociationModel(
    name_company : association.name_company,
    address_company : association.address_company,
    foundationDate : association.foundationDate,
    representative : association.representative,

    socialReasons : association.socialReasons,
    description : association.description,
    phone_company : association.phone_company,
    rfc: association.rfc,

    name_manager : association.name_manager,
    position_manager : association.position_manager,
      cellphone_manager : association.cellphone_manager,
      address_manager : association.address_manager,

      email : association.email,
      password :association.password

  );
}

Association associationModelToAssociation(AssociationModel model) {
  return Association(
    name_company: model.name_company,
    address_company: model.address_company,
    foundationDate: model.foundationDate,
    representative: model.representative,

    socialReasons: model.socialReasons,
    description: model.description,
    phone_company: model.phone_company,
    rfc: model.rfc,

    name_manager: model.name_manager,
    position_manager: model.position_manager,
    cellphone_manager: model.cellphone_manager,
    address_manager: model.address_manager,

    email: model.email,
    password: model.password,
  );
}
