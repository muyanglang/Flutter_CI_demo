import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class GeneratedPluginRegistrant {
  static void registerPlugins() {
    PathProviderPlatform.instance = PathProviderAndroid();
  }
}
