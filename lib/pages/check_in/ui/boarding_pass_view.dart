import 'package:app/widgets/app_loading_screen.dart';
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

    bloc.loadBoardingDate(inside: true);

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
              'Boarding Pass',
              style: kHugeSemiBold.copyWith(
                color: Styles.kTextColor,
              ),
              textAlign: TextAlign.left,
            ),

            kVerticalSpacerSmall,

            Text(
              '''Your check-in has been confirmed. A copy of the boarding pass has been automatically sent to the registered contact person. You may also print, email and download the boarding pass individually below:''',
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
                  state.checkReturn == false) ...[
                for (BoardingPassPassenger currentItem
                    in state.outboundBoardingPassPassenger ?? []) ...[
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: MyCheckbox(
                          label: currentItem.fullName ?? '',
                          changed: (bool value) {
                            bloc.updateStatusOfOutBoundCheckUserForDownload(
                                currentItem, value);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ]
              else if (state.checkedDeparture == false &&
                  state.checkReturn == true) ...[
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
              ]
            ],

            if(state.isDownloading == true) ... [
              const AppLoading(),
            ] else ... [
              kVerticalSpacer,
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                }, //isLoading ? null :
                child: const Text('Email'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var departure = true;
                  if(state.checkedDeparture == false &&
                      state.checkReturn == true){
                    departure = false;
                  }

                  var response = await bloc
                      .getBoardingPassPassengers(departure,onlySelected: true);

                  if(response == true) {
                    Fluttertoast.showToast(
                        msg: 'Files downloaded successfully',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child: const Text('Download'),
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
