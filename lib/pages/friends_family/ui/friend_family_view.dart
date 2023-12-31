import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../blocs/profile/profile_cubit.dart';
import '../../../data/requests/friend_family_add.dart';
import '../../../data/requests/update_friends_family.dart';
import '../../../models/profile.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/ui_utils.dart';
import '../../../widgets/app_loading_screen.dart';
import 'add_fnd_dialog.dart';

class FriendsFamilyView extends StatelessWidget {
  const FriendsFamilyView({Key? key}) : super(key: key);

  showAddFamilyDialog(context) {
    return showBottomDialog(context, const AddFamilyFriendsView());
  }

  showEditFamilyDialog(context, FriendsFamily familyMember) {
    return showBottomDialog(
      context,
      AddFamilyFriendsView(
        isEditing: true,
        familyMember: familyMember,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ProfileCubit>();

    final locale = context.locale.toString();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: !bloc.hasAnyFriends
                      ? const NoFriendFamily()
                      : ListView(
                          children: [
                            for (FriendsFamily currentItem in state
                                    .profile?.userProfile?.friendsAndFamily ??
                                []) ...[
                              if ((state.deleteMember || state.updatingFnF) &&
                                  (state.deletingId ?? '') ==
                                      currentItem.friendsAndFamilyID
                                          .toString()) ...[
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
                                        onPressed: () async {
                                          //Navigator.pop(context);
                                          UpdateFriendsFamily? updateObject =
                                              await showEditFamilyDialog(
                                                  context, currentItem);
                                          if (updateObject != null) {
                                            bloc.editFamilyMember(updateObject);
                                          }
                                        },
                                        child: Text(
                                          'familyDetail.edit'.tr(),
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

                                          bloc.deleteFnF(currentItem
                                              .friendsAndFamilyID
                                              .toString());
                                        },
                                        child:  Text(
                                          'familyDetail.delete'.tr(),
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
                      bloc.addFamilyMember(response);
                    }
                    //Navigator.pop(context);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Row(
                      children:  [
                        const Icon(Icons.add_circle_outline),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            'familyDetail.newFamilyFriends'.tr(),
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

class NoFriendFamily extends StatelessWidget {
  final String? text;

  const NoFriendFamily({
    Key? key, this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Text(text ?? 'familyDetail.noFnF'.tr()),
      ),
    );
  }
}
