const String _unsupported = 'File system access is not supported on web preview.';

Future<void> createDirectory(String path) async => throw UnsupportedError(_unsupported);

Future<bool> directoryExists(String path) async => throw UnsupportedError(_unsupported);

Future<List<String>> listBackupFiles(String path) async =>
    throw UnsupportedError(_unsupported);

Future<void> deleteFile(String path) async => throw UnsupportedError(_unsupported);

Future<String> readFileAsString(String path) async =>
    throw UnsupportedError(_unsupported);

Future<void> writeFileAsString(String path, String content) async =>
    throw UnsupportedError(_unsupported);

Future<int> lastModifiedMillis(String path) async =>
    throw UnsupportedError(_unsupported);