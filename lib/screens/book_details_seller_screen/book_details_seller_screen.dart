import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../home_screen_page/home_screen_page.dart';
import 'widgets/chipviewpersona_item_widget.dart';

// ignore_for_file: must_be_immutable
class BookDetailsSellerScreen extends StatelessWidget {
  BookDetailsSellerScreen({super.key});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageStack(context),
                  SizedBox(height: 23.v),
                  Container(
                    width: 319.h,
                    margin: EdgeInsets.only(
                      left: 16.h,
                      right: 54.h,
                    ),
                    child: Text(
                      "Project Management for the Unofficial Proect Manager",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 10.v),
                  Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "Kory Kogon, Suzette Blakemore, and James wood",
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  SizedBox(height: 8.v),
                  Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "A FanklinConvey Title",
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  SizedBox(height: 21.v),
                  CustomElevatedButton(
                    text: "180 pages",
                    margin: EdgeInsets.symmetric(horizontal: 16.h),
                    leftIcon: Container(
                      margin: EdgeInsets.only(right: 9.h),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgUilBook,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: 27.v),
                  _buildBookDetailsColumn(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildImageStack(BuildContext context) {
    return SizedBox(
      height: 333.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgE50c016fB6a84184x128,
            height: 321.v,
            width: 390.h,
            alignment: Alignment.topCenter,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 333.v,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              decoration:
                  AppDecoration.gradientOnErrorContainerToOnErrorContainer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgE50c016fB6a84184x128,
                    height: 220.v,
                    width: 153.h,
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 6.v),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 277.v),
                      padding: EdgeInsets.symmetric(
                        horizontal: 33.h,
                        vertical: 16.v,
                      ),
                      decoration:
                          AppDecoration.fillOnSecondaryContainer.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath:
                                ImageConstant.imgGgReadOnprimarycontainer,
                            height: 18.adaptSize,
                            width: 18.adaptSize,
                            margin: EdgeInsets.only(bottom: 4.v),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              bottom: 5.v,
                            ),
                            child: Text(
                              "1.7k",
                              style:
                                  CustomTextStyles.titleSmallSecondaryContainer,
                            ),
                          ),
                          Opacity(
                            opacity: 0.3,
                            child: Padding(
                              padding: EdgeInsets.only(left: 32.h),
                              child: SizedBox(
                                height: 24.v,
                                child: VerticalDivider(
                                  width: 1.h,
                                  thickness: 1.v,
                                  color: theme.colorScheme.secondaryContainer,
                                ),
                              ),
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgBasilStarOutline,
                            height: 15.adaptSize,
                            width: 15.adaptSize,
                            margin: EdgeInsets.only(
                              left: 48.h,
                              top: 3.v,
                              bottom: 6.v,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              top: 2.v,
                              bottom: 4.v,
                            ),
                            child: Text(
                              "4.8",
                              style:
                                  CustomTextStyles.titleSmallSecondaryContainer,
                            ),
                          ),
                          Opacity(
                            opacity: 0.3,
                            child: Padding(
                              padding: EdgeInsets.only(left: 47.h),
                              child: SizedBox(
                                height: 24.v,
                                child: VerticalDivider(
                                  width: 1.h,
                                  thickness: 1.v,
                                  color: theme.colorScheme.secondaryContainer,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 38.h,
                              top: 3.v,
                              bottom: 3.v,
                            ),
                            child: Text(
                              " 30 RM",
                              style: theme.textTheme.titleSmall,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBookDetailsColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About this Book",
            style: CustomTextStyles
                .titleMediumAbhayaLibreExtraBoldOnPrimaryContainer,
          ),
          SizedBox(height: 8.v),
          Container(
            width: 351.h,
            margin: EdgeInsets.only(right: 6.h),
            child: Text(
              "Getting Along (2022) describes the importance of workplace interactions and their effecs on productivity and creaiviy.",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall,
            ),
          ),
          SizedBox(height: 14.v),
          Wrap(
            runSpacing: 8.v,
            spacing: 8.h,
            children: List<Widget>.generate(
                4, (index) => const ChipviewpersonaItemWidget()),
          )
        ],
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homeScreenPage;
      case BottomBarEnum.Explore:
        return "/";
      case BottomBarEnum.Library:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homeScreenPage:
        return const HomeScreenPage();
      default:
        return const DefaultWidget();
    }
  }
}
