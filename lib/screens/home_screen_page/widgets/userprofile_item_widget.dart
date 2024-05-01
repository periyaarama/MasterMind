import 'package:flutter/material.dart';
import '../../../core/app_export.dart'; // ignore: must_be_immutable

class UserprofileItemWidget extends StatelessWidget {
  const UserprofileItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128.h,
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
          Text(
            "Mark mcallister",
            style: CustomTextStyles.labelMediumPrimary,
          ),
          SizedBox(height: 8.v),
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
                  "8m",
                  style: theme.textTheme.labelMedium,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
