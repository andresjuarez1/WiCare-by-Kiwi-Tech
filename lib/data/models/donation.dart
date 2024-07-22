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
    return Donation(
      id: json['id'],
      idCompany: json['id_company'],
      status: json['status'],
      companyName: json['company']['name'],
    );
  }
}
