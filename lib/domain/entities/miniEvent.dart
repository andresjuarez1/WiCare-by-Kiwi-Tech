//associationName

// lib/domain/entities/volunteer_profile.dart

class Minievent {
  final String name;
  final String associationName;

  Minievent({
    required this.name,
    required this.associationName,

  });

  factory Minievent.fromJson(Map<String, dynamic> json) {
    return Minievent(
      name: json['name'],
      associationName: json['associationName'],

    );
  }
}
