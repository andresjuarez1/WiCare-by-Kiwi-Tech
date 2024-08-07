import '../../domain/entities/associationProfile.dart';
import '../models/associationProfile_model.dart';

ProfileAssociationModel profileToProfileModel(AssociationProfile profile) {
  return ProfileAssociationModel(
    name: profile.name,
    cellphone: profile.cellphone,
    location: profile.location,
    description: profile.description,
    email: profile.email,
    profilePicture: profile.profilePicture,
  );
}

AssociationProfile profileModelToProfile(ProfileAssociationModel profileModel) {
  return AssociationProfile(
    name: profileModel.name,
    cellphone: profileModel.cellphone,
    location: profileModel.location,
    description: profileModel.description,
    email: profileModel.email,
    profilePicture: profileModel.profilePicture,
  );
}
