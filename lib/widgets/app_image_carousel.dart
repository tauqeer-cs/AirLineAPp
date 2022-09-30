import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppImageCarousel extends StatefulWidget {
  final List<Widget> items;
  final double aspectRatio;
  final CarouselController? controller;
  final double viewPort;
  final bool showIndicator;
  final bool autoPlay;

  const AppImageCarousel({
    Key? key,
    required this.items,
    this.controller,
    this.viewPort = 1,
    this.aspectRatio = 16 / 9,
    required this.showIndicator,
    required this.autoPlay,
  }) : super(key: key);

  @override
  State<AppImageCarousel> createState() => _AppImageCarouselState();
}

class _AppImageCarouselState extends State<AppImageCarousel> {
  int _current = 0;
  late CarouselController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? CarouselController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            padEnds: false,
            viewportFraction: widget.viewPort,
            autoPlay: widget.autoPlay,
            aspectRatio: widget.aspectRatio,
            enableInfiniteScroll: true,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: widget.items,
        ),
        kVerticalSpacerSmall,
        Visibility(
          visible: widget.showIndicator,
          child: AnimatedSmoothIndicator(
            activeIndex: _current,
            count: widget.items.length,
            effect: ScrollingDotsEffect(
              activeStrokeWidth: 2.6,
              activeDotScale: 1.3,
              maxVisibleDots: 5,
              radius: 10,
              spacing: 5,
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: Styles.kPrimaryColor,
            ),
          ),
        )
      ],
    );
  }
}
