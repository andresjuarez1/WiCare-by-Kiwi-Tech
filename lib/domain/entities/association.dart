// lib/domain/entities/association.dart
class Association {
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

  Association({
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
}