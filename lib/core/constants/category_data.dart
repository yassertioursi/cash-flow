import 'package:flutter/material.dart';
import 'package:cashflow/l10n/app_localizations.dart';

import '../enums/enums.dart';
import 'package:cashflow/core/theme/app_icons.dart';

class CategoryDisplayInfo {
  final IconData icon;
  final String Function(AppLocalizations loc) labelBuilder;

  const CategoryDisplayInfo({
    required this.icon,
    required this.labelBuilder,
  });

  String getLabel(AppLocalizations loc) => labelBuilder(loc);
}

abstract class CategoryRepository {

  static final Map<ETransactionCategory, CategoryDisplayInfo> _categories = {
    ETransactionCategory.food: CategoryDisplayInfo(
      icon: AppIcons.food,
      labelBuilder: _getLabelFood,
    ),
    ETransactionCategory.transport: CategoryDisplayInfo(
      icon: AppIcons.car,
      labelBuilder: _getLabelTransport,
    ),
    ETransactionCategory.bills: CategoryDisplayInfo(
      icon: AppIcons.bills,
      labelBuilder: _getLabelBills,
    ),
    ETransactionCategory.health: CategoryDisplayInfo(
      icon: AppIcons.health,
      labelBuilder: _getLabelHealth,
    ),
    ETransactionCategory.shopping: CategoryDisplayInfo(
      icon: AppIcons.cartShopping,
      labelBuilder: _getLabelShopping,
    ),
    ETransactionCategory.entertainment: CategoryDisplayInfo(
      icon: AppIcons.entertainment,
      labelBuilder: _getLabelEntertainment,
    ),
    ETransactionCategory.salary: CategoryDisplayInfo(
      icon: AppIcons.money,
      labelBuilder: _getLabelSalary,
    ),
    ETransactionCategory.others: CategoryDisplayInfo(
      icon: AppIcons.others,
      labelBuilder: _getLabelOthers,
    ),
  };

  static String _getLabelFood(AppLocalizations loc) => loc.lbFood;
  static String _getLabelTransport(AppLocalizations loc) => loc.lbTransport;
  static String _getLabelBills(AppLocalizations loc) => loc.lbBills;
  static String _getLabelHealth(AppLocalizations loc) => loc.lbHealth;
  static String _getLabelShopping(AppLocalizations loc) => loc.lbShopping;
  static String _getLabelEntertainment(AppLocalizations loc) => loc.lbEntertainment;
  static String _getLabelSalary(AppLocalizations loc) => loc.lbSalary;
  static String _getLabelOthers(AppLocalizations loc) => loc.lbOthers;

  static List<ETransactionCategory> get allCategories => ETransactionCategory.values;

  static int get categoryCount => ETransactionCategory.values.length;

  static CategoryDisplayInfo getDisplayInfo(ETransactionCategory category) {
    return _categories[category]!;
  }

  static IconData getIcon(ETransactionCategory category) {
    return _categories[category]!.icon;
  }

  static String getLabel(ETransactionCategory category, AppLocalizations loc) {
    return _categories[category]!.getLabel(loc);
  }

  static ETransactionCategory getCategoryByIndex(int index) {
    return ETransactionCategory.values[index];
  }

  static ETransactionCategory? getCategoryByLabel(String label, AppLocalizations loc) {
    for (final category in ETransactionCategory.values) {
      if (getLabel(category, loc) == label) {
        return category;
      }
    }
    return null;
  }

  static IconData getIconByLabel(String label, AppLocalizations loc) {
    final category = getCategoryByLabel(label, loc);
    if (category != null) {
      return getIcon(category);
    }
    return AppIcons.category;
  }

  static bool isOthersCategory(String label, AppLocalizations loc) {
    return label == getLabel(ETransactionCategory.others, loc);
  }

  static ETransactionCategory fromLabel(String cat, AppLocalizations loc) {
    var labels = ETransactionCategory.values.map((e) => getLabel(e, loc)).toList();

    var index = labels.indexOf(cat);
    if (index == -1) {
      return ETransactionCategory.others;
    }
    return ETransactionCategory.values[index];
  }
}

