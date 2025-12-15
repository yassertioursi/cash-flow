import 'package:equatable/equatable.dart';

import '../../../../core/enums/enums.dart';

class Transaction extends Equatable {

  final String id;

  final String userId;

  final String name;

  final int amountCents;

  final DateTime date;

  final ETransactionType type;

  final ETransactionCategory category;

  const Transaction({
    required this.id,
    required this.userId,
    required this.name,
    required this.amountCents,
    required this.type,
    required this.date,
    required this.category,
  });

  double get amountAsDouble => amountCents / 100.0;

  int get amount => amountCents ~/ 100;

  int get cents => amountCents % 100;

  @override
  List<Object?> get props => [id, userId, name, amountCents, date, type, category];

  @override
  String toString() {
    return 'Transaction(id: $id, userId: $userId, name: $name, amountCents: $amountCents, type: $type, date: $date, category: $category)';
  }
}

