import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/utils/string_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_image.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BundleCard extends StatelessWidget {
  final InboundBundle? inboundBundle;
  final bool isDeparture;

  const BundleCard(
      {Key? key, required this.inboundBundle, required this.isDeparture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final state =
        context.watch<SearchFlightCubit>().state;
    final persons = state.filterState?.numberPerson;
    final focusedPerson = persons?.persons
        .firstWhereOrNull((element) => element == selectedPerson);

    final bundle = isDeparture
        ? focusedPerson?.departureBundle
        : focusedPerson?.returnBundle;
    final cmsBundles = context.watch<CmsSsrCubit>().state.bundleGroups;
    final image = cmsBundles.firstWhereOrNull((element) => element.code == inboundBundle?.bundle?.codeType)?.image;
    return GestureDetector(
      onTap: () {
        context.read<SearchFlightCubit>().addBundleToPerson(selectedPerson, inboundBundle, isDeparture);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        width: 500.w,
        child: AppCard(
          child: Column(
            children: [
              image!=null ? AppImage(
                imageUrl: image,
              ):Image.asset("assets/images/design/package.png"),
              kVerticalSpacer,
              Text(inboundBundle?.bundle?.description?.capitalize() ??
                  "No Service Bundle"),
              kVerticalSpacer,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: inboundBundle?.detail?.bundleServiceDetails
                        ?.map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(e.description?.capitalize() ?? ""),
                        ))
                        .toList() ??
                    [],
              ),
              kVerticalSpacer,
              MoneyWidget(amount: inboundBundle?.bundle?.amount, currency: inboundBundle?.bundle?.currencyCode),
              kVerticalSpacer,
              Radio<InboundBundle?>(
                value: inboundBundle,
                groupValue: bundle,
                onChanged: (value) {
                  context.read<SearchFlightCubit>().addBundleToPerson(selectedPerson, value, isDeparture);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
