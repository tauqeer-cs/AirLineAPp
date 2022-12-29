import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/styles.dart';
import '../../../theme/typography.dart';

class FriendsFamilyView extends StatelessWidget {
  const FriendsFamilyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: SizedBox(
              height: 48.h,
              child: Row(
                children: [
                   Text('Bob Kane',style: kMediumMedium.copyWith(color: Styles.kTextColor),),
                  Expanded(child: Container(),),
                  SizedBox(
                    width: 70.w,
                    height: 32.h,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Edit',
                        style: kSmallRegular,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SizedBox(
                      width: 70.w,
                      height: 32.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Delete',
                          style: kSmallRegular,
                        ),
                      ),
                    ),
                  ),

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
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
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
      ),
    );
  }
}
