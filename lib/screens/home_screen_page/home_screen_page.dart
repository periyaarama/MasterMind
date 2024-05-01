import 'package:flutter/material.dart';
import 'package:master_mind/widgets/app_bar/appbar_profile.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import 'widgets/userprofile1_item_widget.dart';
import 'widgets/userprofile2_item_widget.dart';
import 'widgets/userprofile_item_widget.dart'; // ignore_for_file: must_be_immutable

class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 4.v),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.h),
                      child: Text(
                        "Continue reading",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.v),
                  _buildContinueReading(context),
                  SizedBox(height: 33.v),
                  _buildForYou(context),
                  SizedBox(height: 24.v),
                  _buildTrending(context),
                  SizedBox(height: 23.v),
                  _buildFiveMinutesRead(context)
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
              text: "Good Afternoon",
            ),
            SizedBox(height: 5.v),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 163.h,
                child: Divider(
                  color: appTheme.green100,
                  endIndent: 97.h,
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        // IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pushNamed(AppRoutes.accountScreen);
        //     },
        //     icon: const Padding(
        //       padding: EdgeInsets.fromLTRB(0, 2, 2, 0),
        //       child: Icon(
        //         Icons.person,
        //         color: Colors.white,
        //       ),
        //     ))
        AppbarProfile(
          imagePath: ImageConstant.imgEllipse170x70,
          margin: EdgeInsets.fromLTRB(22.h, 19.v, 22.h, 16.v),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.accountScreen);
          },
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildContinueReading(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 8.h,
        right: 24.h,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: AppDecoration.fillOnError.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgE50c016fB6a84,
            height: 133.v,
            width: 80.h,
            margin: EdgeInsets.only(top: 16.v),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 15.h,
              top: 16.v,
              bottom: 8.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "The good guy",
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 3.v),
                Opacity(
                  opacity: 0.8,
                  child: Text(
                    "Mark mcallister",
                    style: CustomTextStyles.labelMediumPrimary_1,
                  ),
                ),
                SizedBox(height: 24.v),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 3.v,
                        bottom: 4.v,
                      ),
                      child: Container(
                        height: 4.v,
                        width: 185.h,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(
                            2.h,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            2.h,
                          ),
                          child: LinearProgressIndicator(
                            value: 0.66,
                            backgroundColor:
                                theme.colorScheme.primary.withOpacity(0.2),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.8,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.h),
                        child: Text(
                          "65%",
                          style: CustomTextStyles.labelMediumPrimary_1,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15.v),
                Container(
                  height: 40.adaptSize,
                  width: 40.adaptSize,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                    borderRadius: BorderRadius.circular(
                      20.h,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: appTheme.black900.withOpacity(0.1),
                        spreadRadius: 2.h,
                        blurRadius: 2.h,
                        offset: const Offset(
                          2,
                          2,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildForYou(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 24.h),
            child: _buildNorseMythology(
              context,
              trendingText: "For you",
              showallOne: "Show all",
            ),
          ),
          SizedBox(height: 14.v),
          SizedBox(
            height: 260.v,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8.h,
                );
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.bookDetailsScreen);
                    },
                    child: const UserprofileItemWidget());
              },
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTrending(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 24.h),
            child: _buildNorseMythology(
              context,
              trendingText: "Trending",
              showallOne: "Show all",
            ),
          ),
          SizedBox(height: 15.v),
          SizedBox(
            height: 260.v,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8.h,
                );
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.bookDetailsScreen);
                    },
                    child: const Userprofile1ItemWidget());
              },
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFiveMinutesRead(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 24.h),
            child: _buildNorseMythology(
              context,
              trendingText: "5-Minutes read",
              showallOne: "Show all",
            ),
          ),
          SizedBox(height: 16.v),
          SizedBox(
            height: 260.v,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8.h,
                );
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.bookDetailsScreen);
                    },
                    child: const Userprofile2ItemWidget());
              },
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildNorseMythology(
    BuildContext context, {
    required String trendingText,
    required String showallOne,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          trendingText,
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.onError.withOpacity(1),
          ),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(
            top: 3.v,
            bottom: 5.v,
          ),
          child: Text(
            showallOne,
            style: CustomTextStyles.labelLargeAbhayaLibreExtraBoldGreen100
                .copyWith(
              color: appTheme.green100,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 4.h,
            top: 3.v,
            bottom: 4.v,
          ),
          child: CustomIconButton(
            height: 16.adaptSize,
            width: 16.adaptSize,
            padding: EdgeInsets.all(1.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgVector,
            ),
          ),
        )
      ],
    );
  }
}
