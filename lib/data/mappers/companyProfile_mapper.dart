import '../../domain/entities/companyProfile.dart';
import '../models/companyProfile_model.dart';

ProfileCompanyModel profileToProfileModel(CompanyProfile profile) {
  return ProfileCompanyModel(
    name: profile.name,
    cellphone: profile.cellphone,
    location: profile.location,
    description: profile.description,
    email: profile.email,
  );
}

CompanyProfile profileModelToProfile(ProfileCompanyModel profileModel) {
  return CompanyProfile(
    name: profileModel.name,
    cellphone: profileModel.cellphone,
    location: profileModel.location,
    description: profileModel.description,
    email: profileModel.email,
  );
}
