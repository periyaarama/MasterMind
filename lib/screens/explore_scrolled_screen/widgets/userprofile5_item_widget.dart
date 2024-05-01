import 'package:flutter/material.dart';
import '../../../core/app_export.dart'; // ignore: must_be_immutable

class Userprofile5ItemWidget extends StatelessWidget {
  const Userprofile5ItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgE50c016fB6a842,
            height: 184.v,
            width: 128.h,
          ),
          SizedBox(height: 8.v),
          Text(
            "Norse mythology",
            style: theme.textTheme.labelLarge,
          ),
          SizedBox(height: 2.v),
          Text(
            "Neil Gaiman",
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
