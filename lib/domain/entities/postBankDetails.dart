class BankDetails {
  final String name;
  final String number;
  final String bank;

  BankDetails({
    required this.name,
    required this.number,
    required this.bank,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'bank': bank,
    };
  }
}
