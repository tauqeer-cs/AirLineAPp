import 'package:app/widgets/app_loading_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String? imageUrl;
  final Color? color;
  final double? borderRadius;
  final BoxFit? boxFit;
  final double? height, width;

  const AppImage({
    Key? key,
    this.imageUrl,
    this.color,
    this.borderRadius,
    this.boxFit,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl?.isEmpty ?? true
        ? AppDefaultImage(color: color)
        : ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
            child: CachedNetworkImage(
              imageUrl: imageUrl!,
              color: color,
              height: height,
              width: width,
              fit: boxFit ?? BoxFit.cover,
              colorBlendMode: BlendMode.darken,
              placeholder: (context, url) => const AppLoading(),
              errorWidget: (context, url, error) =>
                  AppDefaultImage(color: color),
            ),
          );
  }
}

class AppDefaultImage extends StatelessWidget {
  final Color? color;

  const AppDefaultImage({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/native/logo_new.png',
      color: color,
    );
  }
}
