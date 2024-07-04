import '../../domain/entities/associationProfile.dart';
import '../../domain/entities/companyProfile.dart';
import '../../domain/entities/volunteerProfile.dart';
import '../models/associationProfile_model.dart';
import '../models/companyProfile_model.dart';
import '../models/volunteerProfile_model.dart';

// Convierte un objeto Profile a ProfileModel
ProfileCompanyModel profileToProfileModel(CompanyProfile profile) {
  return ProfileCompanyModel(
    name: profile.name,
    cellphone: profile.cellphone,
    location: profile.location,
    description: profile.description,
    email: profile.email,
  );
}

// Convierte un objeto ProfileModel a Profile
CompanyProfile profileModelToProfile(ProfileCompanyModel profileModel) {
  return CompanyProfile(
    name: profileModel.name,
    cellphone: profileModel.cellphone,
    location: profileModel.location,
    description: profileModel.description,
    email: profileModel.email,
  );
}
