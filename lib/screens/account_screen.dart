import 'package:flutter/material.dart';
import 'package:master_mind/screens/home_screen_container_screen.dart';
import 'package:master_mind/screens/sign_up_screen.dart';
import '../core/app_export.dart';
import '../theme/custom_button_style.dart';
//import '../widgets/app_bar/appbar_leading_image.dart';
import '../widgets/app_bar/appbar_subtitle.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/custom_outlined_button.dart';
import 'home_screen_page/home_screen_page.dart';

// ignore_for_file: must_be_immutable
class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 6.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5.v),
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account",
                          style: CustomTextStyles
                              .headlineSmallAbhayaLibreExtraBoldOnPrimaryContainer,
                        ),
                        SizedBox(height: 4.v),
                        SizedBox(
                          width: 84.h,
                          child: Divider(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 23.v),
                        _buildRowJohnDoe(context),
                        SizedBox(height: 24.v),
                        const Divider(),
                        SizedBox(height: 23.v),
                        _buildRowUilCreditCard(context,
                            payment: "Profile details", onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.profileDetailsScreen);
                        }),
                        _buildRowUilCreditCard(
                          context,
                          payment: "Payment",
                        ),
                        _buildRowUilCreditCard(
                          context,
                          payment: "Subscription",
                        ),
                        const Divider(),
                        SizedBox(height: 23.v),
                        _buildRowUilCreditCard(
                          context,
                          payment: "FAQs",
                        ),
                        _buildRowUilCreditCard(
                          context,
                          payment: "Logout",
                          imageconstant: ImageConstant.imgUilSignout,
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SignUpScreen()), // SignupScreen is your signup screen widget
                              (route) =>
                                  false, // This will remove all previous routes from the stack
                            );
                          },
                        ),

                        _buildRowUilCreditCard(context,
                            payment: "Delete Account",
                            imageconstant: ImageConstant.imgMdiDelete),
                        // Row(
                        //   children: [
                        //     CustomIconButton(
                        //       height: 40.adaptSize,
                        //       width: 40.adaptSize,
                        //       padding: EdgeInsets.all(9.h),
                        //       child: CustomImageView(
                        //         imagePath: ImageConstant.imgUilSignout,
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: EdgeInsets.only(
                        //         left: 16.h,
                        //         top: 12.v,
                        //         bottom: 10.v,
                        //       ),
                        //       child: Text(
                        //         "Logout",
                        //         style: CustomTextStyles.titleSmallAlegreyaSans,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     CustomIconButton(
                        //       height: 42.adaptSize,
                        //       width: 42.adaptSize,
                        //       padding: EdgeInsets.all(9.h),
                        //       child: CustomImageView(
                        //         imagePath: ImageConstant.imgMdiDelete,
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: EdgeInsets.only(
                        //         left: 16.h,
                        //         top: 12.v,
                        //         bottom: 12.v,
                        //       ),
                        //       child: Text(
                        //         "Delete Account",
                        //         style: CustomTextStyles.titleSmallAlegreyaSans,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        SizedBox(height: 46.v),
                        CustomElevatedButton(
                          height: 64.v,
                          text: "Feel free to ask, We are here to help",
                          leftIcon: Container(
                            margin: EdgeInsets.only(right: 10.h),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgSupport,
                              height: 24.adaptSize,
                              width: 24.adaptSize,
                            ),
                          ),
                          buttonStyle: CustomButtonStyles.fillBlueGray,
                          buttonTextStyle:
                              CustomTextStyles.titleSmallAlegreyaSansPrimary,
                        )
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
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      // leading: AppbarLeadingImage(
      //   imagePath: ImageConstant.imgIcons,
      //   margin: EdgeInsets.only(
      //     left: 16.h,
      //     top: 32.v,
      //     bottom: 16.v,
      //   ),
      // ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Color(0XFFC3CCCC),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: AppbarSubtitle(
        text: "Home",
        margin: EdgeInsets.only(left: 8.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowJohnDoe(BuildContext context) {
    return Row(
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgEllipse170x70,
          height: 70.adaptSize,
          width: 70.adaptSize,
          radius: BorderRadius.circular(
            35.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 15.h,
            top: 14.v,
            bottom: 14.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "John Doe",
                style: CustomTextStyles.titleMediumAbhayaLibreExtraBold,
              ),
              SizedBox(height: 4.v),
              Text(
                "john.doe@example.com",
                style: CustomTextStyles.titleSmallSecondaryContainer,
              )
            ],
          ),
        ),
        const Spacer(),
        CustomOutlinedButton(
          width: 100.h,
          text: "Premuim",
          margin: EdgeInsets.symmetric(vertical: 21.v),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.sellerDetailsScreen);
          },
        )
      ],
    );
  }

  /// Section Widget
  // Widget _buildBottomBar(BuildContext context) {
  //   return CustomBottomBar(
  //     onChanged: (BottomBarEnum type) {
  //       Navigator.pushNamed(
  //           navigatorKey.currentContext!, getCurrentRoute(type));
  //     },
  //   );
  // }

  /// Common widget
  Widget _buildRowUilCreditCard(BuildContext context,
      {required String payment, String? imageconstant, Function? onTap}) {
    return ListTile(
      leading: CustomIconButton(
        height: 40.adaptSize,
        width: 40.adaptSize,
        padding: EdgeInsets.all(9.h),
        child: CustomImageView(
          imagePath: imageconstant ?? ImageConstant.imgUilCreditCard,
        ),
      ),
      title: Text(
        payment,
        style: CustomTextStyles.titleSmallAlegreyaSans.copyWith(
          color: appTheme.blueGray50,
        ),
      ),
      trailing: CustomImageView(
        imagePath: ImageConstant.imgArrowRight,
        height: 24.adaptSize,
        width: 24.adaptSize,
        margin: EdgeInsets.symmetric(vertical: 8.v),
      ),

      onTap: () => onTap?.call(), // Navigate back on tap
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
