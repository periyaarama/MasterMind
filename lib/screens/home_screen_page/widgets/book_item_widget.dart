import 'package:flutter/material.dart';
import 'package:master_mind/core/app_export.dart';
import 'package:master_mind/theme/custom_button_style.dart';
import 'package:master_mind/widgets/custom_elevated_button.dart';

class BookItemWidget extends StatelessWidget {
  final DocumentSnapshot<Object?> book;
  const BookItemWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return _buildBookItem(context, book);
  }

  Widget _buildBookItem(BuildContext context, DocumentSnapshot<Object?> book) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: book['imgUrl'] ?? ImageConstant.imgE50c016fB6a84184x128,
            height: 254.v,
            width: 175.h,
            fit: BoxFit.fitHeight,
          ),
          SizedBox(height: 16.v),
          Text(
            book['title'],
            style: CustomTextStyles.titleSmallAlegreyaSans,
          ),
          SizedBox(height: 1.v),
          Text(
            book['author'],
            style: CustomTextStyles.labelLargeAbhayaLibreExtraBold,
          ),
          SizedBox(height: 8.v),
          SizedBox(
            width: 160.h,
            child: Text(
              book['description'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.labelMediumPrimary,
            ),
          ),
          SizedBox(height: 4.v),
          CustomElevatedButton(
            height: 24.v,
            width: 42.h,
            text: book['title'],
            leftIcon: Container(
              margin: EdgeInsets.only(right: 4.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgIconsOnprimarycontainer,
                height: 16.adaptSize,
                width: 16.adaptSize,
              ),
            ),
            buttonStyle: CustomButtonStyles.fillGray,
            buttonTextStyle: CustomTextStyles.labelMediumOnPrimaryContainer,
          )
        ],
      ),
    );
  }
}
