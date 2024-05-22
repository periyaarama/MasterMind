import 'package:flutter/material.dart';
import '../../../core/app_export.dart'; // ignore: must_be_immutable

class Userprofile3ItemWidget extends StatelessWidget {
  const Userprofile3ItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128.h,
      child: Padding(
        padding: EdgeInsets.only(bottom: 1.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgE50c016fB6a84,
              height: 184.v,
              width: 128.h,
            ),
            SizedBox(height: 8.v),
            Text(
              "The good guy",
              style: theme.textTheme.labelLarge,
            ),
            SizedBox(height: 2.v),
            Text(
              "Mark mcallister",
              style: CustomTextStyles.labelMediumBluegray50_1,
            ),
            SizedBox(height: 7.v),
            Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgGgReadOnprimarycontainer,
                  height: 10.adaptSize,
                  width: 10.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    "2.1k",
                    style: theme.textTheme.labelMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14.h),
                  child: Text(
                    " RM 15",
                    style: theme.textTheme.labelMedium,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgBasilStarOutline,
                  height: 9.adaptSize,
                  width: 9.adaptSize,
                  margin: EdgeInsets.only(
                    left: 19.h,
                    bottom: 2.v,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    "4.7",
                    style: theme.textTheme.labelMedium,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
