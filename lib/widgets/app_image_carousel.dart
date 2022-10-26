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
  final bool infiniteScroll;
  final bool showArrow;

  const AppImageCarousel({
    Key? key,
    required this.items,
    this.controller,
    this.viewPort = 1,
    this.aspectRatio = 16 / 9,
    required this.showIndicator,
    required this.autoPlay,
    required this.infiniteScroll,
    this.showArrow = false,
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
    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.showArrow? 20.0:0),
              child: CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  padEnds: false,
                  viewportFraction: widget.viewPort,
                  autoPlay: widget.autoPlay,
                  aspectRatio: widget.aspectRatio,
                  enableInfiniteScroll: widget.infiniteScroll,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                items: widget.items,
              ),
            ),
          ),
          Column(
            children: [

              /*Visibility(
                visible: widget.showIndicator,
                child: Column(
                  children: [
                    kVerticalSpacerSmall,
                    AnimatedSmoothIndicator(
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
                  ],
                ),
              )*/
            ],
          ),
          Visibility(
            visible: widget.showArrow,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: ()=>_controller.previousPage(),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.chevron_left, color: Colors.white,),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>_controller.nextPage(),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.chevron_right, color: Colors.white,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
