import 'package:fpdart/fpdart.dart';

import 'package:cashflow/core/errors/base_failure.dart';
import 'package:cashflow/features/wallet/domain/entities/transaction.dart';

abstract class BaseWalletRepository {
  Future<Either<BaseFailure, List<Transaction>>> getTransactions();
  Future<Either<BaseFailure, Transaction>> getTransactionById(
      String transactionId);

  Future<Either<BaseFailure, Transaction>> addTransaction(
      Transaction transaction);

  Future<Either<BaseFailure, Transaction>> updateTransaction(
      Transaction transaction);

  Future<Either<BaseFailure, Unit>> deleteTransaction(String transactionId);
  Future<Either<BaseFailure, Unit>> deleteAllTransactions(String userId);

  Future<Either<BaseFailure, double>> getTotalIncome();
  Future<Either<BaseFailure, double>> getTotalBalance();
  Future<Either<BaseFailure, double>> getTotalExpense();
  Future<Either<BaseFailure, double>> getDailyExpense();
  Future<Either<BaseFailure, double>> getWeeklyExpense();

  Future<Either<BaseFailure, double>> getMonthlySavings(int initialDay);
  Future<Either<BaseFailure, double>> getCurrentMonthExpense(int initialDay);

  Stream<void> get onTransactionsChanged;
}
