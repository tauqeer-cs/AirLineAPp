import 'dart:async';

import 'package:app/app/app_router.dart';
import 'package:app/models/home_content.dart';
import 'package:app/utils/string_utils.dart';
import 'package:app/utils/user_insider.dart';
import 'package:app/widgets/app_image.dart';
import 'package:auto_route/auto_route.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insider/flutter_insider.dart';

import '../../../theme/theme.dart';

class DynamicHomeBanner extends StatefulWidget {
  final HomeContent content;

  const DynamicHomeBanner({Key? key, required this.content}) : super(key: key);

  @override
  State<DynamicHomeBanner> createState() => _DynamicHomeBannerState();
}

class _DynamicHomeBannerState extends State<DynamicHomeBanner> {
  late Timer _timer;
  int _currentPage = 0;

  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      if (_currentPage < (widget.content.items?.length ?? 0)) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

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
                estimatedPageSize: 200,
                controller: _pageController,
                itemCount: widget.content.items?.length ?? 0,
                onPageChanged: (index){
                  _currentPage = index;
                },
                itemBuilder: (context, index) {
                  final e = widget.content.items![index];
                  return InkWell(
                    onTap: (){
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
                      if(e.link == "#") {
                        return;

                      }
                      context.router.push(HomeDetailRoute(url: url.toString()));
                    },
                    child: AppImage(
                      imageUrl: e.mimg,
                    ),
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
                      onTap: () {
                        _currentPage++;

                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      },
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
                      onTap: () {
                        _currentPage--;
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      },
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
