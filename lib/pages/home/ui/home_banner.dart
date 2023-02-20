import 'package:app/app/app_router.dart';
import 'package:app/models/home_content.dart';
import 'package:app/utils/string_utils.dart';
import 'package:app/utils/user_insider.dart';
import 'package:app/widgets/app_image.dart';
import 'package:app/widgets/app_image_carousel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insider/flutter_insider.dart';

import '../../../theme/theme.dart';

class HomeBanner extends StatelessWidget {
  final HomeContent content;

  const HomeBanner({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AppImageCarousel(
            showArrow: true,
            showIndicator: true,
            aspectRatio: 16/8,
            infiniteScroll: true,
            autoPlay: (content.items ?? []).length > 1,
            items: (content.items ?? []).map(
              (e) {
                print("content is ${e.key}");
                return InkWell(
                  onTap: () {
                    FlutterInsider.Instance.tagEvent(
                      InsiderConstants.promotionDetailPageView,
                    )
                        .addParameterWithString(
                          "promotion_title",
                          e.name.setNoneIfNullOrEmpty,
                        )
                        .build();
                    if(e.link == null) return;
                    final url = Uri.parse(e.link!);
                    context.router.push(HomeDetailRoute(url: url.path));
                    /*context.router.push(WebViewRoute(
                        url: e.link ?? "", title: e.name ?? 'Promotion'));*/
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: FittedBox(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: AppImage(
                          imageUrl: e.img,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
        kVerticalSpacerBig,
      ],
    );
  }
}
