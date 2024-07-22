class Donation {
  final int id;
  final int idCompany;
  final String status;
  final String companyName;

  Donation({
    required this.id,
    required this.idCompany,
    required this.status,
    required this.companyName,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    // Verificar si 'company' es un Map
    String companyName = 'Nombre no disponible';
    if (json['company'] is Map<String, dynamic>) {
      companyName = json['company']['name'] ?? companyName;
    }

    return Donation(
      id: json['id'],
      idCompany: json['id_company'],
      status: json['status'],
      companyName: companyName,
    );
  }
}
