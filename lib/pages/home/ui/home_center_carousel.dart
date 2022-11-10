import 'package:app/models/home_content.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_image.dart';
import 'package:app/widgets/app_image_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCenterCarousel extends StatelessWidget {
  final HomeContent content;

  const HomeCenterCarousel({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppImageCarousel(
      aspectRatio: 300 / 600,
      viewPort: 0.9,
      autoPlay: false,
      showIndicator: false,
      infiniteScroll: false,
      items: (content.items ?? [])
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: InkWell(
                onTap: () {},
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 150,
                      left: 0,
                      child: Container(
                        height: 400,
                        width: 0.8.sw,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                                e.style == "Bottom Left Rounded" ? 50 : 12),
                            bottomRight: Radius.circular(
                                e.style == "Bottom Right Rounded" ? 50 : 12),
                            topRight: Radius.circular(
                                e.style == "Top Right Rounded" ? 50 : 12),
                            topLeft: Radius.circular(
                                e.style == "Top Left Rounded" ? 50 : 12),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 0.7.sw,
                            width: 0.7.sw,
                            child: AppImage(imageUrl: e.image),
                          ),
                          kVerticalSpacer,
                          Text(e.title ?? "", style: kHugeSemiBold),
                          kVerticalSpacer,
                          Text(e.description ?? "", style: kLargeMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
