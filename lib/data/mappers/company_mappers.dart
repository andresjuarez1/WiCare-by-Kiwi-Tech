
import '../../domain/entities/company.dart';
import '../models/company_model.dart';

CompanyModel companyToCompanyModel(Company company) {
  return CompanyModel(
    name : company.name,
    foundation_date : company.foundation_date,
    email : company.email,
    password :company.password,
    position : company.position,
    age : company.age,
    name_manager : company.name_manager,
    cellphone_manager : company.cellphone_manager,
    address_manager : company.address_manager,
    genre : company.genre,
    address : company.address,
    context : company.context,
    description : company.description,
    cellphone : company.cellphone,
    RFC: company.RFC,

  );
}

Company companyModelToCompany(CompanyModel model) {
  return Company(
    name: model.name,
    address: model.address,
    foundation_date: model.foundation_date,
    position: model.position,

    context: model.context,
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
