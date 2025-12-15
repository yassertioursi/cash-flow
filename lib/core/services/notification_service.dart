import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_10y.dart' as tz_data;

import 'package:cashflow/injection_container.dart';
import 'package:cashflow/l10n/app_localizations.dart';
import 'package:cashflow/features/settings/domain/entities/notification_preferences.dart';

import '../config/app_config.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const int _dailyReminderId = 1;
  static const int _monthlyReportId = 2;
  static const int _dailyBudgetAlertId = 4;
  static const int _weeklyBudgetAlertId = 5;

  bool get _supported => !kIsWeb;

  NotificationPreferences? _notificationPreferences;

  void updatePreferences(NotificationPreferences prefs) {
    _notificationPreferences = prefs;
  }

  Future<void> init() async {
    if (!_supported) return;

    tz_data.initializeTimeZones();

    final timezoneInfo = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();

    const initSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _plugin.initialize(initSettings);
  }

  Future<void> requestPermissions() async {
    if (!_supported) return;

    final config = sl.get<AppConfig>();

    if (config.platform == TargetPlatform.iOS) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (config.platform == TargetPlatform.android) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }

  bool isInQuietHours() {
    final prefs = _notificationPreferences;
    if (prefs == null || !prefs.quietHoursEnabled) {
      return false;
    }

    final now = TimeOfDay.now();
    final start = prefs.quietHoursStart;
    final end = prefs.quietHoursEnd;

    final nowMinutes = now.hour * 60 + now.minute;
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;

    if (startMinutes > endMinutes) {

      return nowMinutes >= startMinutes || nowMinutes < endMinutes;
    } else {

      return nowMinutes >= startMinutes && nowMinutes < endMinutes;
    }
  }

  Future<void> showTestNotification(String title, String body) async {
    if (!_supported) return;

    if (isInQuietHours()) {

      return;
    }

    await _plugin.show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Testes',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(categoryIdentifier: 'test_notification'),
      ),
    );
  }

  Future<AndroidScheduleMode> _getAndroidScheduleMode() async {
    final config = sl.get<AppConfig>();
    var scheduleMode = AndroidScheduleMode.inexactAllowWhileIdle;

    if (config.platform == TargetPlatform.android) {
      final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      if (androidPlugin != null) {
        final canScheduleExact =
            await androidPlugin.canScheduleExactNotifications();
        if (canScheduleExact == true) {
          scheduleMode = AndroidScheduleMode.exactAllowWhileIdle;
        }
      }
    }

    return scheduleMode;
  }

  Future<bool> _requestiOSPermissions() async {
    final config = sl.get<AppConfig>();

    if (config.platform == TargetPlatform.iOS) {
      final iosPlugin = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      if (iosPlugin != null) {
        final granted = await iosPlugin.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return granted == true;
      }
    }
    return true;
  }

  Future<void> scheduleDailyReminder(
      AppLocalizations loc, TimeOfDay time) async {
    if (!_supported) return;

    if (!await _requestiOSPermissions()) return;

    final scheduleMode = await _getAndroidScheduleMode();

    await _plugin.zonedSchedule(
      _dailyReminderId,
      loc.ntfDailyReminderTitle,
      loc.ntfDailyReminderBody,
      _nextInstanceOfTime(time),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminders',
          loc.ntfDailyReminderChannelName,
          channelDescription: loc.ntfDailyReminderChannelDescription,
        ),
        iOS: const DarwinNotificationDetails(
          categoryIdentifier: 'daily_reminder',
        ),
      ),
      androidScheduleMode: scheduleMode,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelDailyReminder() async {
    if (!_supported) return;
    await _plugin.cancel(_dailyReminderId);
  }

  Future<void> scheduleMonthlyReport(AppLocalizations loc) async {
    if (!_supported) return;

    if (!await _requestiOSPermissions()) return;

    final scheduleMode = await _getAndroidScheduleMode();

    await _plugin.zonedSchedule(
      _monthlyReportId,
      loc.ntfMonthlyReportTitle,
      loc.ntfMonthlyReportBody,
      _nextInstanceOfMonthDay(1, 10, 0),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'monthly_reports',
          loc.ntfMonthlyReportChannelName,
          channelDescription: loc.ntfMonthlyReportChannelDescription,
        ),
        iOS: const DarwinNotificationDetails(
          categoryIdentifier: 'monthly_report',
        ),
      ),
      androidScheduleMode: scheduleMode,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );
  }

  Future<void> cancelMonthlyReport() async {
    if (!_supported) return;
    await _plugin.cancel(_monthlyReportId);
  }

  tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final local = tz.local;
    final now = tz.TZDateTime.now(local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        local, now.year, now.month, now.day, time.hour, time.minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfMonthDay(int day, int hour, int minute) {
    final local = tz.local;
    final now = tz.TZDateTime.now(local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
        local, now.year, now.month, day, hour, minute);

    if (scheduledDate.isBefore(now)) {

      if (now.month == 12) {
        scheduledDate = tz.TZDateTime(local, now.year + 1, 1, day, hour, minute);
      } else {
        scheduledDate = tz.TZDateTime(local, now.year, now.month + 1, day, hour, minute);
      }
    }

    return scheduledDate;
  }

  Future<void> showBackupCompleteNotification({
    required String title,
    required String body,
  }) async {
    if (!_supported) return;

    if (isInQuietHours()) {
      return;
    }

    await _plugin.show(
      3,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'backup_channel',
          'Backup Notifications',
          channelDescription: 'Notifications for backup completion',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(categoryIdentifier: 'backup_notification'),
      ),
    );
  }

  Future<void> showDailyBudgetAlert({
    required String title,
    required String body,
    required String channelName,
    required String channelDescription,
  }) async {
    if (!_supported) return;

    if (isInQuietHours()) return;

    await _plugin.show(
      _dailyBudgetAlertId,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'budget_alerts',
          channelName,
          channelDescription: channelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(
          categoryIdentifier: 'budget_alert',
        ),
      ),
    );
  }

  Future<void> showWeeklyBudgetAlert({
    required String title,
    required String body,
    required String channelName,
    required String channelDescription,
  }) async {
    if (!_supported) return;

    if (isInQuietHours()) return;

    await _plugin.show(
      _weeklyBudgetAlertId,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'budget_alerts',
          channelName,
          channelDescription: channelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(
          categoryIdentifier: 'budget_alert',
        ),
      ),
    );
  }
}

