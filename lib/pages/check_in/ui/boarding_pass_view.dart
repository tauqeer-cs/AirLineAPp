import 'package:app/widgets/app_loading_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../data/responses/boardingpass_passenger_response.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../select_change_flight/ui/booking_refrence_label.dart';
import '../bloc/check_in_cubit.dart';
import 'check_in_steps.dart';

class BoardingPassView extends StatelessWidget {
  const BoardingPassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<CheckInCubit>();
    var state = bloc.state;


    return Padding(
      padding: kPageHorizontalPadding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            BookingReferenceLabel(
              refText: state.pnrEntered,
            ),
            SizedBox(
              width: double.infinity,
              child: CheckInSteps(
                isLast: true,
                passedSteps: const [
                  CheckInStep.bookingDetails,
                ],
                onTopStepTaped: (i) {},
              ),
            ),
            kVerticalSpacer,
            kVerticalSpacerMini,
            Text(
              'boardingPass'.tr(),
              style: kHugeSemiBold.copyWith(
                color: Styles.kTextColor,
              ),
              textAlign: TextAlign.left,
            ),
            kVerticalSpacerSmall,
            Text(
              'checkInConfirmedMessage'.tr(),
              style: kMediumMedium.copyWith(
                color: Styles.kTextColor,
              ),
              textAlign: TextAlign.left,
            ),
            kVerticalSpacer,
            if (bloc.state.loadBoardingDate == true) ...[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: AppLoading(),
              ),
            ] else ...[
              if (state.checkedDeparture == true &&
                  state.checkReturn == true) ...[

                Text(
                  'departFlight'.tr(),
                  style: kLargeHeavy.copyWith(
                    color: Styles.kTextColor,
                  ),
                  textAlign: TextAlign.left,
                ),

                    kVerticalSpacerSmall,

                for (BoardingPassPassenger currentItem
                in state.outboundBoardingPassPassenger ?? []) ...[
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: MyCheckbox(
                          label: currentItem.fullName ?? '',
                          changed: (bool value) {
                            bloc.updateOutBoundtatusForDownload(
                                currentItem, value);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ],


              if (
                  state.checkReturn == true) ...[
                kVerticalSpacer,
                Text(
                  'returningFlight'.tr(),
                  style: kLargeHeavy.copyWith(
                    color: Styles.kTextColor,
                  ),
                  textAlign: TextAlign.left,
                ),
                kVerticalSpacerSmall,


                for (BoardingPassPassenger currentItem
                    in state.inboundBoardingPassPassenger ?? []) ...[
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: MyCheckbox(
                          label: currentItem.fullName ?? '',
                          changed: (bool value) {
                            bloc.updateStatusOfInBoundCheckUserForDownload(
                                currentItem, value);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ] ,


            ],
            if (state.isDownloading == true) ...[
              const AppLoading(),
            ] else ...[
              kVerticalSpacer,
              OutlinedButton(
                onPressed: () async {
                  String? email = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      var departure = true;
                      if (state.checkedDeparture == false &&
                          state.checkReturn == true) {
                        departure = false;
                      }
                      var bothSides = false;
                      if (state.checkedDeparture == true &&
                          state.checkReturn == true) {
                        bothSides = true;
                      }
                      return EmailBoardingPassView(
                        departure: departure,
                        bothSides: bothSides,
                      );
                    },
                  );

                  if (email != null) {}
                }, //isLoading ? null :
                child:  Text('confirmationView.email'.tr()),
              ),
              kVerticalSpacerSmall,

              ElevatedButton(
                onPressed: () async {
                  var departure = true;
                  if (state.checkedDeparture == false &&
                      state.checkReturn == true) {
                    departure = false;
                  }

                  var bothSides = false;

                  if (state.checkedDeparture == true &&
                      state.checkReturn == true) {
                    bothSides = true;
                  }

                  var response = await bloc.getBoardingPassPassengers(departure,
                      onlySelected: true, boodSides: bothSides);

                  if (response == true) {
                    Fluttertoast.showToast(
                        msg: 'fileDownloadedSuccessfully'.tr(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child:  Text('download'.tr()),
              )
            ],
          ],
        ),
      ),
    );
  }
}

class MyCheckbox extends StatefulWidget {
  final String label;

  final Function(bool) changed;

  const MyCheckbox({Key? key, required this.label, required this.changed})
      : super(key: key);

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
        widget.changed(isChecked);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isChecked ? Styles.kPrimaryColor : Colors.white,
          borderRadius: BorderRadius.circular(35),
          border: Border.all(
            color: isChecked ? Styles.kPrimaryColor : Colors.grey,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: isChecked
                    ? Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(Icons.check,
                            color: Styles.kPrimaryColor, size: 16),
                      )
                    : Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                      ),
              ),
              Text(
                widget.label,
                style: kLargeMedium.copyWith(
                  color: isChecked ? Colors.white : Styles.kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailBoardingPassView extends StatefulWidget {
  final bool departure;
  final bool bothSides;

  final bool onlySelected;

  const EmailBoardingPassView(
      {Key? key, required this.departure, required this.bothSides,this.onlySelected = true})
      : super(key: key);

  @override
  _EmailBoardingPassViewState createState() => _EmailBoardingPassViewState();
}

class _EmailBoardingPassViewState extends State<EmailBoardingPassView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool success = false;

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<CheckInCubit>();
    var state = bloc.state;

    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "finalFlightDetail.emailBoardingPass".tr(),
            textAlign: TextAlign.center,
            style: kHugeHeavy.copyWith(color: Styles.kTextColor),
          ),
          Expanded(
            child: Container(),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                success
                    ? 'boardingPassSuccess'.tr()
                    : 'pleaseFillEmailPass'.tr(),
                style: kMediumRegular.copyWith(color: Styles.kTextColor),
              ),
            ),
            kVerticalSpacerMini,
            if (success == false) ...[
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'pleaseEnterEmail'.tr();
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'pleaseEnterEmail'.tr();
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration:  InputDecoration(
                  hintText: 'enterEmailAddress'.tr(),
                ),
              ),
              kVerticalSpacer,
            ],
            if(state.isDownloading) ... [
              const AppLoading(),
            ] else ... [
              ElevatedButton(
                child: Text(success ? 'close'.tr() : 'send'.tr()),
                onPressed: () async {
                  if (success == true) {

                    Navigator.pop(context);

                    return;
                  }
                  if (_formKey.currentState!.validate()) {
                    //Navigator.of(context).pop(_emailController.text);

                    var response = await bloc.getBoardingPassPassengers(
                        widget.departure,
                        onlySelected: widget.onlySelected,
                        boodSides: widget.bothSides,
                        email: true,
                        emailText: _emailController.text);

                    if (response == true) {
                      setState(() {
                        success = true;
                      });
                    }
                  }
                },
              ),
            ],

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
