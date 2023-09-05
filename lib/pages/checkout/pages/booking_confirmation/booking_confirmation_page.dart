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

import '../../../../widgets/app_loading_screen.dart';
import '../../../check_in/bloc/check_in_cubit.dart';

class BookingConfirmationPage extends StatefulWidget {
  final String bookingId;
  final String status;
  final Widget? summaryToShow;

  final String pnr;

  final bool isMMb;


  const BookingConfirmationPage({
    Key? key,
    @PathParam('id') required this.bookingId,
    required this.status, this.summaryToShow,  this.isMMb = false,  this.pnr = '',
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
          if(widget.isMMb == false) {
            confirmationBloc = ConfirmationCubit()
              ..getConfirmation(widget.bookingId, widget.status);
          }
          else if(widget.isMMb == true) {
            confirmationBloc = ConfirmationCubit();
          }


          return confirmationBloc!;
        },
        child: Scaffold(
          appBar: AppAppBar(
            title: appAppNewTitle ??
                (confirmationBloc == null || widget.isMMb
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
                    state.bookingStatus == 'BIP' || state.bookingStatus == 'PPA' || state.bookingStatus == 'PEN') {
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
                if(state.blocState == BlocState.loading) {

                  return  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: AppLoading(),
                  );

                }
                if(this.widget.isMMb == true) {
                  return ConfirmationView(
                    pnr: widget.bookingId,
                    status: widget.status,
                    isMMb: widget.isMMb,
                    summaryToShow: widget.summaryToShow,
                  );
                }
                return blocBuilderWrapper(
                  blocState: state.blocState,
                  finishedBuilder: ConfirmationView(
                    pnr: widget.bookingId,
                    status: widget.status,
                    isMMb: widget.isMMb,
                    summaryToShow: widget.summaryToShow,
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
    if (widget.status == 'PPB' || widget.status == 'PEN' || widget.status == 'BIP' || widget.status == 'PPA') {
      return 'confirmationView.statusPending'.tr();
    }
    else if(widget.status == 'CON') {
      return ("confirmation".tr());

    }
    if (widget.status == 'EXP') {
      return 'confirmationView.statusExpired'.tr();
    }

    if(this.widget.isMMb ) {

      return ("Unsuccessful".tr());

    }
    return ("confirmation".tr());
  }
}
