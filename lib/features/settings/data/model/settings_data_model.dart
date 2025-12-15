import 'dart:convert';

import '../../domain/entities/user_preferences.dart';

import 'data_preferences_model.dart';
import 'budget_preferences_model.dart';
import 'appearance_preferences_model.dart';
import 'notification_preferences_model.dart';

class UserPreferencesModel extends UserPreferences {
  UserPreferencesModel({
    required super.id,
    required super.appearancePreferences,
    required super.notificationPreferences,
    required super.budgetPreferences,
    required super.dataPreferences,
  });

  factory UserPreferencesModel.defaults({required String id}) {
    return UserPreferencesModel(
      id: id,
      appearancePreferences: AppearancePreferencesModel.defaults(),
      notificationPreferences: NotificationPreferencesModel.defaults(),
      budgetPreferences: BudgetPreferencesModel.defaults(),
      dataPreferences: DataPreferencesModel.defaults(),
    );
  }

  factory UserPreferencesModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;

    final appearance = _decodeJsonField(json['appearancePreferences']);
    final notifications = _decodeJsonField(json['notificationPreferences']);
    final budget = _decodeJsonField(json['budgetPreferences']);
    final data = _decodeJsonField(json['dataPreferences']);

    return UserPreferencesModel(
      id: id,
      appearancePreferences: AppearancePreferencesModel.fromJson(appearance),
      notificationPreferences:
          NotificationPreferencesModel.fromJson(notifications),
      budgetPreferences: BudgetPreferencesModel.fromJson(budget),
      dataPreferences: DataPreferencesModel.fromJson(data),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,

      'appearancePreferences':
          jsonEncode(AppearancePreferencesModel.toJson(appearancePreferences)),
      'notificationPreferences':
          jsonEncode(NotificationPreferencesModel.toJson(notificationPreferences)),
      'budgetPreferences': 
          jsonEncode(BudgetPreferencesModel.toJson(budgetPreferences)),
      'dataPreferences': 
          jsonEncode(DataPreferencesModel.toJson(dataPreferences)),
    };
  }

  factory UserPreferencesModel.fromEntity(UserPreferences entity) {
    return UserPreferencesModel(
      id: entity.id,
      appearancePreferences: entity.appearancePreferences,
      notificationPreferences: entity.notificationPreferences,
      budgetPreferences: entity.budgetPreferences,
      dataPreferences: entity.dataPreferences,
    );
  }

  static Map<String, dynamic> _decodeJsonField(dynamic value) {
    if (value == null) {
      return {};
    }
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is String) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is Map<String, dynamic>) {
          return decoded;
        }
      } catch (_) {

      }
    }
    return {};
  }
}
