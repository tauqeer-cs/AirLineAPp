import 'package:app/app/app_bloc_helper.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/confirmation_view.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/animations/booking_loader.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class BookingConfirmationPage extends StatelessWidget {
  final String bookingId;

  const BookingConfirmationPage({
    Key? key,
    @PathParam('id') required this.bookingId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      child: BlocProvider(
        create: (context) => ConfirmationCubit()..getConfirmation(bookingId),
        child: Scaffold(
          // floatingActionButton: Builder(
          //   builder: (context) {
          //     return FloatingActionButton(
          //       onPressed: (){
          //         context.read<ConfirmationCubit>().getConfirmation(bookingId);
          //       },
          //     );
          //   }
          // ),
          appBar: AppAppBar(
            title: "Confirmation",
            height: 60.h,
            centerTitle: true,
          ),
          body: BlocBuilder<ConfirmationCubit, ConfirmationState>(
            builder: (context, state) {
              return blocBuilderWrapper(
                blocState: state.blocState,
                finishedBuilder: const ConfirmationView(),
                loadingBuilder: const SingleChildScrollView(
                  padding: kPagePadding,
                  child: BookingLoader(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
