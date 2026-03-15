// ── Wallet Model ──────────────────────────────────────────────────────────────
class WalletModel {
  final double balance;
  final String currency;

  WalletModel({required this.balance, required this.currency});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return WalletModel(
      balance: (data['balance'] as num).toDouble(),
      currency: data['currency'] as String? ?? 'BDT',
    );
  }
}

class TransactionModel {
  final int id;
  final String type; // credit | debit
  final double amount;
  final String description;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.createdAt,
  });

  bool get isCredit => type == 'credit';

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'] as int,
        type: json['type'] as String,
        amount: (json['amount'] as num).toDouble(),
        description: json['description'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
      );
}
