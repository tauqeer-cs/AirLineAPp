import 'dart:ui';

import 'package:app/app/app_router.dart';
import 'package:app/models/home_content.dart';
import 'package:app/pages/home/bloc/home/home_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_image.dart';
import 'package:app/widgets/app_image_carousel.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDealGrid extends StatelessWidget {
  final HomeContent content;

  const HomeDealGrid({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1),
          itemCount: content.items?.length ?? 0,
          itemBuilder: (context, index) {
            final e = content.items![index];
            return GestureDetector(
              onTap: () {
                context.router.push(WebViewRoute(url: e.link ?? ""));
              },
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: AppImage(
                        imageUrl: e.image,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.title ?? "",
                                  style: kLargeSemiBold.copyWith(
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 4.0,
                                        color: Color.fromRGBO(0, 0, 0, 0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                kVerticalSpacerSmall,
                                Text(
                                  e.description ?? "",
                                  style: kMediumMedium.copyWith(
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 4.0,
                                        color: Color.fromRGBO(0, 0, 0, 0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                kVerticalSpacerSmall,
                              ],
                            ),
                          ),
                        ),
                        GreyCard(
                          margin: 0,
                          edgeInsets: EdgeInsets.all(8),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Start from",
                                      style: kSmallMedium.copyWith(
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "RM ${e.price}",
                                      style: kMediumMedium.copyWith(
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Styles.kPrimaryColor,
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        kVerticalSpacerBig,
      ],
    );
  }
}
