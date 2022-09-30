import 'dart:ui';

import 'package:app/models/home_content.dart';
import 'package:app/pages/home/bloc/home/home_cubit.dart';
import 'package:app/pages/home/ui/home_center_carousel.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_image.dart';
import 'package:app/widgets/app_image_carousel.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCenter extends StatelessWidget {
  final HomeContent content;

  const HomeCenter({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/design/bgsky.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(content.title ?? "", style: kGiantHeavy),
            Text(content.titleBold ?? "", style: kGiantHeavy),
            kVerticalSpacerBig,
            Text(content.subtitle ?? "", style: kMediumSemiBold),
            kVerticalSpacer,
            Text(content.description ?? "", style: kMediumMedium),
            kVerticalSpacer,
            ElevatedButton(
                onPressed: () {}, child: Text(content.buttonText ?? "")),
            kVerticalSpacer,
            Transform.translate(
              offset: Offset(-15, 0),
              child: Image.asset("assets/images/design/plane.png", width: 200.w,),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(content.cardSectionTitleNoBold ?? "", style: kGiantRegular),
                      Text(content.cardSectionTitleBold ?? "", style: kGiantHeavy),
                    ],
                  ),
                ),
                Expanded(child: Image.asset("assets/images/design/skycloud.png", width: 200.w,)),
              ],
            ),
            kVerticalSpacerHuge,
            HomeCenterCarousel(content: content),
          ],
        ),
      ),
    );
  }
}
