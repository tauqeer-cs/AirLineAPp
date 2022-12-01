import 'package:app/app/app_flavor.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigRepository {
  static FirebaseRemoteConfig? _remoteConfig;
  static String? minimumVersion;
  static String? recommendedVersion;
  static String? title;
  static String? subtitle;
  static bool showTimer = false;

  static init() async {
    _remoteConfig = FirebaseRemoteConfig.instance;
    await _remoteConfig!.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 15),
      minimumFetchInterval: const Duration(hours: 12),
    ));
    await _remoteConfig!.fetchAndActivate();
  }

  static versionChecking() async {
    if (_remoteConfig == null) {
      await init();
    }
    print("flavor ${AppFlavor.minimumVersion}");
    minimumVersion =  _remoteConfig?.getString(AppFlavor.minimumVersion) ?? "1.0.0";
    recommendedVersion =  _remoteConfig?.getString(AppFlavor.recommendedVersion) ?? "1.0.0";
    title =  _remoteConfig?.getString("updateTitle") ?? "New Update Available";
    subtitle =  _remoteConfig?.getString("updateDescription") ?? "";
    showTimer = _remoteConfig?.getBool("showTimer") ?? false;
    print("minimumVersion $minimumVersion recommendedVersion $recommendedVersion");
  }
}
