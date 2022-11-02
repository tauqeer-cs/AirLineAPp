import 'package:app/app/app_router.dart';
import 'package:app/models/home_content.dart';
import 'package:app/pages/home/bloc/home/home_cubit.dart';
import 'package:app/widgets/app_image.dart';
import 'package:app/widgets/app_image_carousel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/theme.dart';

class HomeBanner extends StatelessWidget {
  final HomeContent content;

  HomeBanner({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AppImageCarousel(
            showArrow: true,
            aspectRatio: 393 / 185,
            showIndicator: true,
            infiniteScroll: true,
            autoPlay: (content.items ?? []).length>1,
            items: (content.items ?? [])
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      context.router.push(WebViewRoute(url: e.link ?? ""));

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: AppImage(imageUrl: e.img),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        kVerticalSpacerBig,
      ],
    );
  }
}
