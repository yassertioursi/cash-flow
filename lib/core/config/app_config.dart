import 'package:flutter/foundation.dart';

import 'app_config_stub.dart'
    if (dart.library.io) 'app_config_io.dart' as plat;

enum Environment { dev, stage, prod }

class AppConfig {

  final String appName;
  final String apiBaseUrl;
  final Environment flavor;

  final TargetPlatform _platform;

  AppConfig({
    required this.appName,
    required this.apiBaseUrl,
    required this.flavor,
    TargetPlatform? platformOverride,
  }) : _platform = platformOverride ?? defaultTargetPlatform;

  TargetPlatform get platform => _platform;

  bool get isAndroid => _platform == TargetPlatform.android;

  bool get isIOS => _platform == TargetPlatform.iOS;

  bool get isWeb => kIsWeb;

  bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);
  bool get isWindows => !isWeb && plat.isWindows;
  bool get isLinux => !isWeb && plat.isLinux;
  bool get isMacOS => !isWeb && plat.isMacOS;
}
