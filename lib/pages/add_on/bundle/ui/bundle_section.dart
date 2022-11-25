import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/add_on/ui/passenger_selector.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/app_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/utils/string_utils.dart';

class BundleSection extends StatelessWidget {
  final bool isDeparture;
  const BundleSection({Key? key, this.isDeparture = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ssr = context.watch<BookingCubit>().state.verifyResponse?.flightSSR;
    final bundles =
        isDeparture ? ssr?.bundleGroup?.outbound : ssr?.bundleGroup?.inbound;
    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bundle",
            style: kHugeSemiBold.copyWith(color: Styles.kOrangeColor),
          ),
          kVerticalSpacer,
           PassengerSelector(isDeparture: isDeparture,),
          kVerticalSpacer,
          buildBundleCards(bundles, isDeparture),
        ],
      ),
    );
  }

  Column buildBundleCards(List<InboundBundle>? bundles, bool isDeparture) {
    return Column(
      children: [
        ...bundles?.map(
              (e) {
                return Column(
                  children: [
                    NewBundleCard(inboundBundle: e, isDeparture: isDeparture),
                    kVerticalSpacerSmall,
                  ],
                );
              },
            ).toList() ??
            []
      ],
    );
  }
}

class NewBundleCard extends StatelessWidget {
  final InboundBundle? inboundBundle;
  final bool isDeparture;

  const NewBundleCard(
      {Key? key, required this.inboundBundle, required this.isDeparture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final state = context.watch<SearchFlightCubit>().state;
    final persons = state.filterState?.numberPerson;
    final focusedPerson = persons?.persons
        .firstWhereOrNull((element) => element == selectedPerson);

    final bundle = isDeparture
        ? focusedPerson?.departureBundle
        : focusedPerson?.returnBundle;
    final cmsBundles = context.watch<CmsSsrCubit>().state.bundleGroups;
    final image = cmsBundles
        .firstWhereOrNull(
            (element) => element.code == inboundBundle?.bundle?.codeType)
        ?.image;
    return InkWell(
      onTap: () {
        context
            .read<SearchFlightCubit>()
            .addBundleToPerson(selectedPerson, inboundBundle, isDeparture);
      },
      child: Card(
        elevation: 2,
        child: Stack(
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.only(top: 15, right: 50, left: 15),
              leading: Radio<InboundBundle?>(
                value: inboundBundle,
                groupValue: bundle,
                onChanged: (value) {
                  context
                      .read<SearchFlightCubit>()
                      .addBundleToPerson(selectedPerson, value, isDeparture);
                },
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inboundBundle?.bundle?.description?.capitalize() ??
                        "No Bundle Service",
                    style: kHugeHeavy,
                  ),
                  ...inboundBundle?.detail?.bundleServiceDetails
                          ?.map((e) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(e.description?.capitalize() ?? ""),
                              ))
                          .toList() ??
                      []
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inboundBundle?.bundle?.currencyCode ?? "MYR",
                    style: kMediumHeavy,
                  ),
                  Text(
                    NumberUtils.formatNumber(
                        inboundBundle?.bundle?.amount?.toDouble()),
                    style: kHugeHeavy,
                  ),
                ],
              ),
            ),
            Positioned(
              top: -10,
              right: -5,
              child: image != null
                  ? AppImage(imageUrl: image, height: 50)
                  : Image.asset("assets/images/design/package.png", height: 50),
            ),
          ],
        ),
      ),
    );
  }
}
