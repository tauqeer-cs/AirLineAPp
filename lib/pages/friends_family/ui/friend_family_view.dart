import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../blocs/profile/profile_cubit.dart';
import '../../../data/requests/friend_family_add.dart';
import '../../../models/profile.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../widgets/app_loading_screen.dart';
import 'add_fnd_dialog.dart';

class FriendsFamilyView extends StatelessWidget {
  const FriendsFamilyView({Key? key}) : super(key: key);

  showAddFamilyDialog(context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: const Color.fromRGBO(235, 235, 235, 0.85),
      constraints: BoxConstraints(
        maxWidth: 0.9.sw,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (dialogContext) => LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: SizedBox(
          height: 0.5.sh,
          child: const AppLoadingScreen(message: "Loading"),
        ),
        child: const AddFamilyFriendsView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ProfileCubit>();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: ListView(
                    children: [
                      for (FriendsFamily currentItem
                          in state.profile?.userProfile?.friendsAndFamily ??
                              []) ...[
                        if (state.deleteMember &&
                            (state.deletingId ?? '') ==
                                currentItem.friendsAndFamilyID.toString()) ...[
                          Row(
                            children: [
                              Text(
                                currentItem.fullName,
                                style: kMediumMedium.copyWith(
                                    color: Styles.kTextColor),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              const Center(
                                child: AppLoading(),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ] else ...[
                          Row(
                            children: [
                              Text(
                                currentItem.fullName,
                                style: kMediumMedium.copyWith(
                                    color: Styles.kTextColor),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              SizedBox(
                                width: 70.w,
                                height: 32.h,
                                child: OutlinedButton(
                                  onPressed: () {
                                    //Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: kSmallRegular,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: 70.w,
                                height: 32.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigator.pop(context);

                                    bloc.deleteFnF(currentItem.friendsAndFamilyID.toString());

                                  },
                                  child: const Text(
                                    'Delete',
                                    style: kSmallRegular,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Divider(
                  color: Styles.kDisabledButton,
                ),
              ),
              if (state.addingFamily) ...[
                const AppLoading(),
              ] else ...[
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    FriendsFamilyAdd? response =
                        await showAddFamilyDialog(context);

                    if (response != null) {
                      print('Not Null');
                      bloc.addFamilyMember(response);
                    }
                    //Navigator.pop(context);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Row(
                      children: const [
                        Icon(Icons.add_circle_outline),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            'New Family and Friends',
                            style: kMediumRegular,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
