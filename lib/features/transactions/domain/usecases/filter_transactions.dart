import '../../../wallet/domain/entities/transaction.dart';

class FilterTransactions {
  List<Transaction> call(FilterParams params) {
    if (params.filters.isEmpty) return params.allTransactions;

    return params.allTransactions.where((t) {

      return params.filters
          .contains(t.type.toString());
    }).toList();
  }
}

class FilterParams {
  final List<Transaction> allTransactions;
  final List<String> filters;

  FilterParams({
    required this.allTransactions,
    required this.filters,
  });
}
