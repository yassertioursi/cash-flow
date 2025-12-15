import 'dart:io';

Future<void> createDirectory(String path) async {
  final dir = Directory(path);
  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }
}

Future<bool> directoryExists(String path) async => Directory(path).exists();

Future<List<String>> listBackupFiles(String path) async {
  final dir = Directory(path);
  if (!await dir.exists()) return [];

  return dir
      .listSync()
      .where((entity) =>
          entity.path.endsWith('.json') || entity.path.endsWith('.ewb'))
      .map((entity) => entity.path)
      .toList()
    ..sort((a, b) => b.compareTo(a));
}

Future<void> deleteFile(String path) async {
  final file = File(path);
  if (await file.exists()) {
    await file.delete();
  }
}

Future<String> readFileAsString(String path) async => File(path).readAsString();

Future<void> writeFileAsString(String path, String content) async =>
    File(path).writeAsString(content);

Future<int> lastModifiedMillis(String path) async {
  final file = File(path);
  if (!await file.exists()) return 0;
  return FileStat.statSync(path).modified.millisecondsSinceEpoch;
}