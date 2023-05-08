import 'package:app/blocs/airports/airports_cubit.dart';
import 'package:app/models/airports.dart';
import 'package:app/models/home_content.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/user_insider.dart';
import 'package:app/widgets/app_image.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
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
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1),
          itemCount: content.items?.length ?? 0,
          itemBuilder: (_, index) {
            final e = content.items![index];
            return InkWell(
              onTap: () {
                final airports = context.read<AirportsCubit>().state.airports;
                final from =
                    airports.firstWhereOrNull((air) => air.code == e.from);
                final to = airports.firstWhereOrNull((air) => air.code == e.to);

                context
                    .read<FilterCubit>()
                    .updateOriginAirport(from ?? Airports(code: e.from));
                context
                    .read<FilterCubit>()
                    .updateDestinationAirport(to ?? Airports(code: e.to));
                UserInsider.of(context).registerEventWithParameterProduct(
                  InsiderConstants.promotionSearchFlightButtonClicked,
                );
                final tabsRouter = AutoTabsRouter.of(context);
                tabsRouter.setActiveIndex(0);
                //context.router.push(WebViewRoute(url: e.link ?? ""));
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
                                Flexible(
                                  child: AutoSizeText(
                                    e.title ?? "",
                                    style: kLargeSemiBold.copyWith(
                                      color: Colors.white,
                                      shadows: [
                                        const Shadow(
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 4.0,
                                          color: Color.fromRGBO(0, 0, 0, 0.5),
                                        ),
                                      ],
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                kVerticalSpacerSmall,
                                Text(
                                  e.description ?? "",
                                  style: kMediumMedium.copyWith(
                                    color: Colors.white,
                                    shadows: [
                                      const Shadow(
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
                          color: const Color.fromRGBO(255, 255, 255, 0.5),
                          edgeInsets: const EdgeInsets.all(8),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      "startFrom".tr(),
                                      style: kSmallMedium.copyWith(
                                        color: Colors.black,
                                      ),
                                      maxLines: 1,
                                    ),
                                    AutoSizeText(
                                      "${e.currency ?? 'MYR'} ${e.price}",
                                      style: kMediumMedium.copyWith(
                                          color: Colors.black),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Styles.kPrimaryColor,
                                child: const Icon(
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
