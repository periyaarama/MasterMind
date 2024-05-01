import 'package:flutter/material.dart';
import '../../../core/app_export.dart'; // ignore: must_be_immutable

class Userprofile3ItemWidget extends StatelessWidget {
  const Userprofile3ItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128.h,
      child: Padding(
        padding: EdgeInsets.only(bottom: 2.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgE50c016fB6a841,
              height: 184.v,
              width: 128.h,
            ),
            SizedBox(height: 7.v),
            Text(
              "Explore your create mind to positivity",
              style: theme.textTheme.labelLarge,
            ),
            SizedBox(height: 3.v),
            Text(
              "Royryan Mercado",
              style: theme.textTheme.labelMedium,
            ),
            SizedBox(height: 6.v),
            Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgGgRead,
                  height: 16.adaptSize,
                  width: 16.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4.h,
                    top: 2.v,
                    bottom: 1.v,
                  ),
                  child: Text(
                    "5m",
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
