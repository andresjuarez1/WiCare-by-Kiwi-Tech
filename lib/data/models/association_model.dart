// lib/data/models/association_model.dart
class AssociationModel {
  final String name_company;
  final String address_company;
  final String foundationDate;
  final String representative;

  final String socialReasons;
  final String description;
  final String phone_company;
  final String rfc;

  final String name_manager;
  final String position_manager;
  final String cellphone_manager;
  final String address_manager;
  
  final String email;
  final String password;

  AssociationModel({
    required this.name_company,
    required this.address_company,
    required this.foundationDate,
    required this.representative,

    required this.socialReasons,
    required this.description,
    required this.phone_company,
    required this.rfc,

    required this.name_manager,
    required this.position_manager,
    required this.cellphone_manager,
    required this.address_manager,
    
    required this.email,
    required this.password,
  });

  factory AssociationModel.fromJson(Map<String, dynamic> json) {
    return AssociationModel(
      name_company: json['name_company'],
      address_company: json['address_company'],
      foundationDate: json['foundationDate'],
      representative: json['representative'],

      socialReasons: json['socialReasons'],
      description: json['description'],
      phone_company: json['phone_company'],
      rfc: json['rfc'],

      name_manager: json['name_manager'],
      position_manager: json['position_manager'],
      cellphone_manager: json['cellphone_manager'],
      address_manager: json['address_manager'],
      
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name_company_company': name_company,
      'address_company': address_company,
      'foundationDate': foundationDate,
      'representative': representative,
      
      'socialReasons': socialReasons,
      'description': description,
      'phone_company': phone_company,
      'rfc': rfc,

      'name_manager': name_manager,
      'position_manager': position_manager,
      'cellphone_manager': cellphone_manager,
      'address_manager': address_manager,

      
      'email': email,
      'password': password,
    };
  }
}
