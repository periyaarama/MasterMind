import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../theme/custom_button_style.dart';
import '../widgets/app_bar/appbar_title.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart'; // ignore_for_file: must_be_immutable

class MyLibraryPage extends StatelessWidget {
  const MyLibraryPage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 11.v),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 13.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow(context),
                  SizedBox(height: 24.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 4.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgE50c016fB6a84,
                                  height: 254.v,
                                  width: 175.h,
                                ),
                                SizedBox(height: 16.v),
                                Text(
                                  "The good guy",
                                  style:
                                      CustomTextStyles.titleSmallAlegreyaSans,
                                ),
                                SizedBox(height: 1.v),
                                Text(
                                  "Mark mcallister",
                                  style: CustomTextStyles
                                      .labelLargeAbhayaLibreExtraBold,
                                ),
                                SizedBox(height: 8.v),
                                SizedBox(
                                  width: 160.h,
                                  child: Text(
                                    "A story about a guy who was very good until the very end when every",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles.labelMediumPrimary,
                                  ),
                                ),
                                SizedBox(height: 14.v),
                                CustomElevatedButton(
                                  height: 24.v,
                                  width: 42.h,
                                  text: "8m",
                                  leftIcon: Container(
                                    margin: EdgeInsets.only(right: 4.h),
                                    child: CustomImageView(
                                      imagePath: ImageConstant
                                          .imgIconsOnprimarycontainer,
                                      height: 16.adaptSize,
                                      width: 16.adaptSize,
                                    ),
                                  ),
                                  buttonStyle: CustomButtonStyles.fillGray,
                                  buttonTextStyle: CustomTextStyles
                                      .labelMediumOnPrimaryContainer,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgE50c016fB6a842,
                                  height: 254.v,
                                  width: 175.h,
                                ),
                                SizedBox(height: 16.v),
                                Text(
                                  "The good guy",
                                  style:
                                      CustomTextStyles.titleSmallAlegreyaSans,
                                ),
                                SizedBox(height: 1.v),
                                Text(
                                  "Mark mcallister",
                                  style: CustomTextStyles
                                      .labelLargeAbhayaLibreExtraBold,
                                ),
                                SizedBox(height: 8.v),
                                SizedBox(
                                  width: 160.h,
                                  child: Text(
                                    "A story about a guy who was very good until the very end when every",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles.labelMediumPrimary,
                                  ),
                                ),
                                SizedBox(height: 14.v),
                                CustomElevatedButton(
                                  height: 24.v,
                                  width: 42.h,
                                  text: "8m",
                                  leftIcon: Container(
                                    margin: EdgeInsets.only(right: 4.h),
                                    child: CustomImageView(
                                      imagePath: ImageConstant
                                          .imgIconsOnprimarycontainer,
                                      height: 16.adaptSize,
                                      width: 16.adaptSize,
                                    ),
                                  ),
                                  buttonStyle: CustomButtonStyles.fillGray,
                                  buttonTextStyle: CustomTextStyles
                                      .labelMediumOnPrimaryContainer,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16.v),
                  _buildRowE50c016fb6a8(context),
                  SizedBox(height: 16.v),
                  _buildRowTheGoodGuy(context),
                  SizedBox(height: 16.v),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 3.h,
                      right: 79.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildRowiconsSeven(
                            context,
                            distanceText: "5m",
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.h),
                            child: _buildRowiconsNine(
                              context,
                              distanceText: "8m",
                            ),
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: _buildRowiconsSeven(
                            context,
                            distanceText: "5m",
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.h),
                            child: _buildRowiconsNine(
                              context,
                              distanceText: "8m",
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Padding(
        padding: EdgeInsets.only(left: 16.h),
        child: Column(
          children: [
            AppbarTitle(
              text: "My Library",
            ),
            SizedBox(height: 2.v),
            SizedBox(
              width: 110.h,
              child: Divider(
                color: appTheme.green100,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 123.h,
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 12.v,
            ),
            decoration: AppDecoration.fillGreen.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgUilBookmarkOnprimary,
                  height: 18.adaptSize,
                  width: 18.adaptSize,
                ),
                Text(
                  "Saved Books",
                  style: CustomTextStyles.titleSmallAlegreyaSansOnPrimary,
                )
              ],
            ),
          ),
          _buildRowCheckedOne(
            context,
            isChecked: ImageConstant.imgIcons,
            label: "In Progress",
          ),
          _buildRowCheckedOne(
            context,
            isChecked: ImageConstant.imgChecked,
            label: "Completed",
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowE50c016fb6a8(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomImageView(
              imagePath: ImageConstant.imgE50c016fB6a84184x128,
              height: 254.v,
              width: 175.h,
              margin: EdgeInsets.only(right: 4.h),
            ),
          ),
          Expanded(
            child: CustomImageView(
              imagePath: ImageConstant.imgE50c016fB6a841,
              height: 254.v,
              width: 175.h,
              margin: EdgeInsets.only(left: 4.h),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowTheGoodGuy(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 4.h),
              child: _buildColumnthegoodgu(
                context,
                dynamicText1: "The good guy",
                dynamicText2: "Mark mcallister",
                dynamicText3:
                    "A story about a guy who was very good until the very end when every",
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: _buildColumnthegoodgu(
                context,
                dynamicText1: "The good guy",
                dynamicText2: "Mark mcallister",
                dynamicText3:
                    "A story about a guy who was very good until the very end when every",
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildRowCheckedOne(
    BuildContext context, {
    required String isChecked,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.outlineOnPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: isChecked,
            height: 18.adaptSize,
            width: 18.adaptSize,
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              label,
              style: CustomTextStyles.titleSmallAlegreyaSans.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildColumnthegoodgu(
    BuildContext context, {
    required String dynamicText1,
    required String dynamicText2,
    required String dynamicText3,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dynamicText1,
          style: CustomTextStyles.titleSmallAlegreyaSans.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(height: 4.v),
        Text(
          dynamicText2,
          style: CustomTextStyles.labelLargeAbhayaLibreExtraBold.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(height: 8.v),
        SizedBox(
          width: 175.h,
          child: Text(
            dynamicText3,
            maxLines: null,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyles.labelMediumPrimary.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }

  /// Common widget
  Widget _buildRowiconsSeven(
    BuildContext context, {
    required String distanceText,
  }) {
    return Container(
      width: 41.h,
      padding: EdgeInsets.symmetric(vertical: 4.v),
      decoration: AppDecoration.fillGreen.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgIconsOnprimarycontainer16x16,
            height: 16.adaptSize,
            width: 16.adaptSize,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.v),
            child: Text(
              distanceText,
              style: CustomTextStyles.labelMediumOnPrimaryContainer.copyWith(
                color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildRowiconsNine(
    BuildContext context, {
    required String distanceText,
  }) {
    return Container(
      width: 42.h,
      padding: EdgeInsets.all(4.h),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgIconsOnprimarycontainer,
            height: 16.adaptSize,
            width: 16.adaptSize,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 4.h,
              bottom: 2.v,
            ),
            child: Text(
              distanceText,
              style: CustomTextStyles.labelMediumOnPrimaryContainer.copyWith(
                color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
              ),
            ),
          )
        ],
      ),
    );
  }
}
