import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class BaggageNotice extends StatelessWidget {
  const BaggageNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  carryNotice= context.watch<CmsSsrCubit>().state.carryNotice;
    final  oversizedNotice= context.watch<CmsSsrCubit>().state.oversizedNotice;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Carry-on Baggage", style: kGiantSemiBold),
          kVerticalSpacer,
          Html(data: carryNotice?.content ?? ""),
          kVerticalSpacerBig,
          kVerticalSpacer,
          const Text("Travel with Oversized items? ", style: kGiantSemiBold),
          kVerticalSpacer,
          Html(data: oversizedNotice?.content ?? ""),
        ],
      ),
    );
  }
}
