import 'package:app/app/app_router.dart';
import 'package:app/models/home_content.dart';
import 'package:app/utils/string_utils.dart';
import 'package:app/utils/user_insider.dart';
import 'package:app/widgets/app_image.dart';
import 'package:app/widgets/app_image_carousel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insider/flutter_insider.dart';

import '../../../theme/theme.dart';

class DynamicHomeBanner extends StatelessWidget {
  final HomeContent content;
  final PageController pageController = PageController();

  DynamicHomeBanner({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ExpandablePageView.builder(
                animateFirstPage: true,
                estimatedPageSize: 100,
                controller: pageController,
                itemCount: content.items?.length ?? 0,
                itemBuilder: (context, index) {
                  final e = content.items![index];
                  return AppImage(
                    imageUrl: e.img,
                  );
                },
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      ),
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      ),
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        kVerticalSpacerBig,
      ],
    );
  }
}
