class Volunteer {
  final String name;
  final String description;
  final String age;
  final String curp;
  final String cellphone;
  final String postal;
  final String latitude;
  final String longitude;
  final String occupation;
  final String genre;
  final String email;
  final String password;

  Volunteer({
    required this.name,
    required this.description,
    required this.age,
    required this.curp,
    required this.cellphone,
    required this.postal,
    required this.latitude,
    required this.longitude,
    required this.occupation,
    required this.genre,
    required this.email,
    required this.password,
  });

  // Método toJson para convertir a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'age': age,
      'curp': curp,
      'cellphone': cellphone,
      'postal': postal,
      'latitude': latitude,
      'longitude': longitude,
      'occupation': occupation,
      'genre': genre,
      'email': email,
      'password': password,
    };
  }
}
