
import 'package:app/data/repositories/remote_config_repository.dart';
import 'package:app/widgets/dialogs/app_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';

class WidgetUtils {
  static appUpdateDialog(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Version appVersion = Version.parse(packageInfo.version);
    Version minimumVersion =
        Version.parse(RemoteConfigRepository.minimumVersion ?? "1.0.0");
    Version recommendedVersion =
        Version.parse(RemoteConfigRepository.recommendedVersion ?? "1.0.0");
    if(appVersion >= recommendedVersion && appVersion >= minimumVersion) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(appVersion >= minimumVersion);
          },
          child: AppConfirmationDialog(
            showCloseButton: appVersion >= minimumVersion,
            title: RemoteConfigRepository.title ?? "",
            subtitle: RemoteConfigRepository.subtitle ?? "",
            confirmText: "Okay",
          ),
        );
      },
    );
  }
}
