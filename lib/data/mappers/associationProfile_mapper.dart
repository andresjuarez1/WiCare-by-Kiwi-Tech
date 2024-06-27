import '../../domain/entities/associationProfile.dart';
import '../../domain/entities/volunteerProfile.dart';
import '../models/associationProfile_model.dart';
import '../models/volunteerProfile_model.dart';

// Convierte un objeto Profile a ProfileModel
ProfileAssociationModel profileToProfileModel(AssociationProfile profile) {
  return ProfileAssociationModel(
    name: profile.name,
    cellphone: profile.cellphone,
    occupation: profile.occupation,
    genre: profile.genre,
    email: profile.email,
  );
}

// Convierte un objeto ProfileModel a Profile
AssociationProfile profileModelToProfile(ProfileAssociationModel profileModel) {
  return AssociationProfile(
    name: profileModel.name,
    cellphone: profileModel.cellphone,
    occupation: profileModel.occupation,
    genre: profileModel.genre,
    email: profileModel.email,
  );
}
