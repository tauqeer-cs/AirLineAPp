import 'package:app/app/app_flavor.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionBannerWidget extends StatelessWidget {
  final Widget child;

  const VersionBannerWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppFlavor.appFlavor != Flavor.production
        ? FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: Banner(
                    message:
                        '${snapshot.data?.version}+${snapshot.data?.buildNumber}',
                    location: BannerLocation.bottomEnd,
                    textStyle: kMediumHeavy.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    child: child,
                  ),
                );
              }
              return SizedBox.shrink();
            },
          )
        : child;
  }
}
