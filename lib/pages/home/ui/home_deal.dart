import 'dart:ui';

import 'package:app/models/home_content.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_image.dart';
import 'package:app/widgets/app_image_carousel.dart';
import 'package:flutter/material.dart';

class HomeDeal extends StatelessWidget {
  final HomeContent content;

  const HomeDeal({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(content.title ?? "", style: kGiantHeavy),
        kVerticalSpacer,
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AppImageCarousel(
            aspectRatio: 1.7,
            infiniteScroll: false,
            viewPort: 0.85,
            autoPlay: false,
            showIndicator: false,
            items: (content.items ?? [])
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: AppImage(
                              imageUrl: e.image,
                              boxFit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(10, 10, 40, 10),
                            child: ClipRect(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey.shade200.withOpacity(0.5),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.title ?? "",
                                        style: kHugeSemiBold,
                                      ),
                                      kVerticalSpacerSmall,
                                      Text(
                                        e.description ?? "",
                                        style: kMediumMedium.copyWith(
                                            color: Colors.black.withOpacity(0.5)),
                                      ),
                                      kVerticalSpacerSmall,
                                      Text(
                                        "Start from",
                                        style: kMediumMedium.copyWith(
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "RM ${e.price}",
                                        style: kHugeSemiBold.copyWith(
                                            color: Colors.black),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: const Text("Buy Now"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
