import 'package:cashflow/l10n/app_localizations.dart';

import '../enums/enums.dart';

class TransactionTypeRepository {

  static String getLabel(ETransactionType type, AppLocalizations loc) {
    switch (type) {
      case ETransactionType.income:
        return loc.lbIncome;
      case ETransactionType.expense:
        return loc.lbExpense;
    }
  }

  static ETransactionType? fromLabel(String label, AppLocalizations loc) {
    if (label == loc.lbIncome) return ETransactionType.income;
    if (label == loc.lbExpense) return ETransactionType.expense;
    return null;
  }
}
