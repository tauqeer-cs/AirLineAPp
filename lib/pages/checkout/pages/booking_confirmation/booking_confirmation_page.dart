import 'package:app/app/app_bloc_helper.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/confirmation_view.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/animations/booking_loader.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../check_in/bloc/check_in_cubit.dart';

class BookingConfirmationPage extends StatefulWidget {
  final String bookingId;

  final String status;

  const BookingConfirmationPage({
    Key? key,
    @PathParam('id') required this.bookingId,
    required this.status,
  }) : super(key: key);

  @override
  State<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  @override
  void initState() {
    super.initState();

    print('object');
    //CON == sucess
  }

  ConfirmationCubit? confirmationBloc;

  String? appAppNewTitle;

  @override
  Widget build(BuildContext context) {
    print("booking ${widget.bookingId}");

    CheckInCubit? bloc = context.watch<CheckInCubit>();
//    bloc.resetList();

    return LoaderOverlay(
      useDefaultLoading: false,
      child: BlocProvider(
        create: (context) {
          confirmationBloc = ConfirmationCubit()
            ..getConfirmation(widget.bookingId, widget.status);

          return confirmationBloc!;
        },
        child: Scaffold(
          appBar: AppAppBar(
            title: appAppNewTitle ??
                (confirmationBloc == null
                    ? buildTr()
                    : confirmationBloc!.bookingViewHeading),
            titleColor: Styles.kPrimaryColor,
            height: 60.h,
            centerTitle: true,
          ),
          body: BlocListener<ConfirmationCubit, ConfirmationState>(
            listener: (context, state) {
              //widget.status == 'PPB' || widget.status == 'BIP'
              if (state.bookingStatus.isNotEmpty) {
                if (state.bookingStatus == 'PPB' ||
                    state.bookingStatus == 'BIP') {
                  setState(() {
                    appAppNewTitle = 'confirmationView.statusPending'.tr();
                  });
                } else if (state.bookingStatus == 'EXP') {
                  setState(() {
                    appAppNewTitle = 'confirmationView.statusExpired'.tr();
                  });
                } else if (state.bookingStatus == 'CON') {
                  setState(() {
                    appAppNewTitle = ("confirmation".tr());
                  });
                }
              }
              print('');
            },
            child: BlocBuilder<ConfirmationCubit, ConfirmationState>(
              builder: (context, state) {
                return blocBuilderWrapper(
                  blocState: state.blocState,
                  finishedBuilder: ConfirmationView(
                    pnr: widget.bookingId,
                    status: widget.status,
                  ),
                  loadingBuilder: const SingleChildScrollView(
                    padding: kPagePadding,
                    child: BookingLoader(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String buildTr() {
    if (widget.status == 'PPB' || widget.status == 'BIP') {
      return 'confirmationView.statusPending'.tr();
    }
    if (widget.status == 'EXP') {
      return 'confirmationView.statusExpired'.tr();
    }

    return ("confirmation".tr());
  }
}
