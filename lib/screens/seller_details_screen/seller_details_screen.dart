import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_icon_button.dart';
import '../home_screen_page/home_screen_page.dart';
import 'widgets/userprofile3_item_widget.dart';

// ignore_for_file: must_be_immutable
class SellerDetailsScreen extends StatelessWidget {
  SellerDetailsScreen({super.key});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 16.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5.v),
                    child: Column(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgEllipse1,
                          height: 90.adaptSize,
                          width: 90.adaptSize,
                          radius: BorderRadius.circular(
                            45.h,
                          ),
                        ),
                        SizedBox(height: 6.v),
                        Text(
                          "John Doe",
                          style: theme.textTheme.headlineSmall,
                        ),
                        SizedBox(height: 5.v),
                        Text(
                          "This is my bio",
                          style: theme.textTheme.labelSmall,
                        ),
                        SizedBox(height: 16.v),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgMdiLinkedin,
                              height: 24.adaptSize,
                              width: 24.adaptSize,
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgMdiInstagram,
                              height: 24.adaptSize,
                              width: 24.adaptSize,
                              margin: EdgeInsets.only(left: 9.h),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgPrimeTwitter,
                              height: 24.adaptSize,
                              width: 24.adaptSize,
                              margin: EdgeInsets.only(left: 9.h),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgIcBaselineFacebook,
                              height: 24.adaptSize,
                              width: 24.adaptSize,
                              margin: EdgeInsets.only(left: 9.h),
                            )
                          ],
                        ),
                        SizedBox(height: 17.v),
                        _buildRowBooks(context),
                        SizedBox(height: 48.v),
                        _buildRowBooks1(context),
                        SizedBox(height: 17.v),
                        _buildUserProfile(context)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowBooks(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.symmetric(
        horizontal: 36.h,
        vertical: 7.v,
      ),
      decoration: AppDecoration.fillErrorContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUilBook,
            height: 33.adaptSize,
            width: 33.adaptSize,
            margin: EdgeInsets.only(
              top: 9.v,
              bottom: 6.v,
            ),
          ),
          Container(
            width: 58.h,
            margin: EdgeInsets.only(
              left: 11.h,
              bottom: 2.v,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " Publishes\n       ",
                    style: theme.textTheme.titleSmall,
                  ),
                  TextSpan(
                    text: "35",
                    style: CustomTextStyles.headlineSmallAbhayaLibreExtraBold,
                  )
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const Spacer(
            flex: 53,
          ),
          Opacity(
            opacity: 0.3,
            child: SizedBox(
              height: 49.v,
              child: VerticalDivider(
                width: 1.h,
                thickness: 1.v,
                color: theme.colorScheme.secondaryContainer,
                indent: 7.h,
              ),
            ),
          ),
          const Spacer(
            flex: 46,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgUilHeadphonesAlt,
            height: 34.v,
            width: 33.h,
            margin: EdgeInsets.only(
              top: 7.v,
              bottom: 8.v,
            ),
          ),
          Container(
            width: 56.h,
            margin: EdgeInsets.only(
              left: 17.h,
              bottom: 4.v,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "    ",
                  ),
                  const TextSpan(
                    text: " ",
                  ),
                  TextSpan(
                    text: "Sells\n",
                    style: theme.textTheme.titleSmall,
                  ),
                  TextSpan(
                    text: "12.5 k",
                    style: CustomTextStyles.headlineSmallAbhayaLibreExtraBold,
                  )
                ],
              ),
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowBooks1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8.h,
        right: 24.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Books",
            style: theme.textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              top: 5.v,
              bottom: 4.v,
            ),
            child: Text(
              "Show all",
              style: CustomTextStyles.labelLargeAbhayaLibreExtraBoldPrimary,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 4.h,
              top: 5.v,
              bottom: 2.v,
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
      ),
    );
  }

  /// Section Widget
  Widget _buildUserProfile(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.bookDetailsSellerScreen);
      },
      child: SizedBox(
        height: 270.v,
        child: ListView.separated(
          padding: EdgeInsets.only(left: 8.h),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 8.h,
            );
          },
          itemCount: 3,
          itemBuilder: (context, index) {
            return const Userprofile3ItemWidget();
          },
        ),
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
