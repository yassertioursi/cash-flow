import '../entities/weekly_transaction_data.dart';
import '../../../wallet/domain/entities/transaction.dart';

class CalculateWeeklyTransactions {

  WeeklyTransactionData call(List<Transaction> transactions) {
    final now = DateTime.now();
    final dailyAmounts = <DailyTransactionAmount>[];
    double maxAmount = 0.0;

    for (int i = 6; i >= 0; i--) {
      final day = DateTime(now.year, now.month, now.day).subtract(Duration(days: i));

      final dailyTotal = transactions
          .where((tx) =>
              tx.date.year == day.year &&
              tx.date.month == day.month &&
              tx.date.day == day.day)
          .fold<double>(0.0, (sum, tx) => sum + tx.amount);

      dailyAmounts.add(DailyTransactionAmount(date: day, amount: dailyTotal));

      if (dailyTotal > maxAmount) {
        maxAmount = dailyTotal;
      }
    }

    return WeeklyTransactionData(
      dailyAmounts: dailyAmounts,
      maxAmount: maxAmount,
    );
  }
}
