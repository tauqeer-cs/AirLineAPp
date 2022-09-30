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
      aspectRatio: 300/500,
      viewPort: 0.9,
      autoPlay: false,
      showIndicator: false,
      items: (content.items ?? [])
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: GestureDetector(
                onTap: () {},
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 150,
                      left: 0,
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12),
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
                          AppImage(imageUrl: e.image),
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
