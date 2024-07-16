class Association {
  final String name;
  final String foundation_date;
  final String email;
  final String password;
  final String position;
  final String age;
  final String name_manager;
  final String cellphone_manager;
  final String latitude_manager;
  final String longitude_manager;
  final String genre;
  final String latitude;
  final String longitude;
  final String social_reason;
  final String description;
  final String RFC;
  final String cellphone;

  Association({
    required this.name,
    required this.foundation_date,
    required this.email,
    required this.password,
    required this.position,
    required this.age,
    required this.name_manager,
    required this.cellphone_manager,
    required this.latitude_manager,
    required this.longitude_manager,
    required this.genre,
    required this.latitude,
    required this.longitude,
    required this.social_reason,
    required this.description,
    required this.RFC,
    required this.cellphone,
  });

  toJson() {}
}
