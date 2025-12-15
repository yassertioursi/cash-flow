import 'package:cashflow/features/wallet/data/models/transaction_model.dart';
import 'package:cashflow/core/errors/exceptions.dart';

abstract class BaseWalletLocalDataSource {

  Future<List<TransactionModel>> getLastTransactions();

  Future<void> cacheTransaction(TransactionModel transaction);

  Future<void> deleteTransaction(String transactionId);

  Future<void> deleteAllTransactions(String userId);

  Future<TransactionModel> getTransactionById(String transactionId);

  Future<double> getCurrentMonthExpense(int initialDay);

  Future<double> getTotalIncome();

  Future<double> getTotalBalance();

  Future<double> getTotalExpense();

  Future<double> getMonthlySavings(int initialDay);

  Future<double> getDailyExpense();

  Future<double> getWeeklyExpense();
}
