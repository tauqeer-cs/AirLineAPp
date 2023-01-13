import 'package:app/widgets/app_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../blocs/profile/profile_cubit.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/dialogs/app_confirmation_dialog.dart';
import '../../friends_family/ui/friend_family_view.dart';

class MemberCardViw extends StatelessWidget {
  const MemberCardViw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ProfileCubit>();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Saved payment methods',
                style: kLargeSemiBold,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Details of your default card will be automatically entered for future MYAirline payments. Payment method can be changed at time of booking.',
                style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
              ),
              kVerticalSpacer,
              if (state.profile?.userProfile?.memberCards != null &&
                  state.profile!.userProfile!.memberCards!.isNotEmpty) ...[
                Expanded(
                  child: state.deletingCard ? const Center(child: AppLoading()) : ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return AppCard(
                        customColor: Colors.white,
                        edgeInsets: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/icons/${state.profile!.userProfile!.memberCards![index].cardImageName}.png",
                                width: 40.w,
                                fit: BoxFit.contain,
                              ),
                              if (!state.profile!.userProfile!.memberCards![index].hasCardExpired) ...[
                                 Expanded(
                                  child: Center(
                                    child: Text(
                                      state.profile!.userProfile!.memberCards![index].cardDisplay,
                                      style: kMediumMedium,
                                    ),
                                  ),
                                ),
                              ] else ...[
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.profile!.userProfile!.memberCards![index].cardDisplay,
                                          style: kMediumMedium.copyWith(
                                              color: Styles.kInactiveColor),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          'Expired',
                                          style: kSmallMedium.copyWith(
                                              color: Styles.kActiveColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              InkWell(
                                child: Image.asset(
                                  "assets/images/icons/trash.png",
                                  width: 18.w,
                                  fit: BoxFit.contain,
                                ),
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return AppConfirmationDialog(
                                        title: 'Are you sure you want to delete this card?',
                                        subtitle: "Saved cards can help you checkout faster.",
                                        confirmText: 'Delete',
                                        cancelText: 'Cancel',
                                        onConfirm: () {


                                          bloc.deleteCard(index);


                                        },
                                      );
                                    },
                                  );



                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: state.profile!.userProfile!.memberCards!.length,
                  ),
                ),
              ] else ...[
                const NoFriendFamily(
                  text: 'No Card Saved yet.',
                ),
              ],
              kVerticalSpacer,
              kVerticalSpacer,
            ],
          ),
        );
      },
    );
  }
}
/*
visa.png
unionpay_logo.png
mc.png
trash.png

"expiryDate": "2501",

			"cardHolderName": "Sdfff",
			"token": "8801223000836177736",
			"cardType": "MST",
			"cardNickName": ""


			  {
        "expiryDate": "2501",
        "countryCode": "",
        "cardHolderName": "JENNY",
        "token": "8829022000788477505",
        "cardType": "VSA",
        "cardNickName": "Jenny"
      },

* */
