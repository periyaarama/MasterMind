import 'package:flutter/material.dart';
import '../../../core/app_export.dart'; // ignore: must_be_immutable

class UserprofileItemWidget extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;

  const UserprofileItemWidget({
    super.key,
    required this.title,
    required this.author,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: imageUrl,
            height: 184.v,
            width: 128.h,
          ),
          SizedBox(height: 8.v),
          Text(
            title,
            style: theme.textTheme.labelLarge,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            author,
            style: CustomTextStyles.labelMediumPrimary,
            overflow: TextOverflow.ellipsis,
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
