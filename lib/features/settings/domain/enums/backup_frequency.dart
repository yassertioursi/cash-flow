
enum BackupFrequency {

  none,

  daily,

  weekly,

  monthly;

  static BackupFrequency fromString(String json) {
    return BackupFrequency.values.firstWhere(
      (e) => e.toString().split('.').last == json,
      orElse: () => BackupFrequency.none,
    );
  }
}
