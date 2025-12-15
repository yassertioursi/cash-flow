import 'package:flutter/foundation.dart';

@immutable
class DailyTransactionAmount {
  const DailyTransactionAmount({
    required this.date,
    required this.amount,
  });

  final DateTime date;

  final double amount;
}

@immutable
class WeeklyTransactionData {
  const WeeklyTransactionData({
    required this.dailyAmounts,
    required this.maxAmount,
  });

  final List<DailyTransactionAmount> dailyAmounts;

  final double maxAmount;

  factory WeeklyTransactionData.empty() {
    final now = DateTime.now();
    return WeeklyTransactionData(
      dailyAmounts: List.generate(7, (index) {
        final day = DateTime(now.year, now.month, now.day).subtract(Duration(days: 6 - index));
        return DailyTransactionAmount(date: day, amount: 0.0);
      }),
      maxAmount: 0.0,
    );
  }
}
