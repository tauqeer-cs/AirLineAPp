import 'package:app/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionWidget extends StatefulWidget {
  final Color textColor;

  const VersionWidget({Key? key, required this.textColor}) : super(key: key);

  @override
  State<VersionWidget> createState() => _VersionWidgetState();
}

class _VersionWidgetState extends State<VersionWidget> {
  PackageInfo? packageInfo;

  @override
  void initState() {
    super.initState();
    getPackage();
  }

  getPackage() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: packageInfo != null,
      child: Text(
       '${'version'.tr()} ${packageInfo?.version}',
        style: kMediumSemiBold.copyWith(color: widget.textColor),
      ),
    );
  }
}
