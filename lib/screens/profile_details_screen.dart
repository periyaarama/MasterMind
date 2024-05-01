import 'package:flutter/material.dart';
import 'package:master_mind/widgets/app_bar/appbar_title.dart';
import '../core/app_export.dart';
import '../theme/custom_button_style.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'home_screen_page/home_screen_page.dart';

// ignore_for_file: must_be_immutable
class ProfileDetailsScreen extends StatelessWidget {
  ProfileDetailsScreen({super.key});

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController thisismybiovaluController = TextEditingController();

  TextEditingController valueoneController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(height: 7.v),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5.v),
                      padding: EdgeInsets.symmetric(horizontal: 15.h),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Profile details",
                              style: theme.textTheme.headlineSmall,
                            ),
                          ),
                          SizedBox(height: 24.v),
                          SizedBox(
                            height: 90.adaptSize,
                            width: 90.adaptSize,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgEllipse1,
                                  height: 90.adaptSize,
                                  width: 90.adaptSize,
                                  radius: BorderRadius.circular(
                                    45.h,
                                  ),
                                  alignment: Alignment.center,
                                ),
                                CustomIconButton(
                                  height: 32.adaptSize,
                                  width: 32.adaptSize,
                                  padding: EdgeInsets.all(7.h),
                                  decoration: IconButtonStyleHelper.fillPrimary,
                                  alignment: Alignment.bottomRight,
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgUilUpload,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 16.v),
                          Text(
                            "Change profile picture",
                            style: CustomTextStyles.labelLargePrimary,
                          ),
                          SizedBox(height: 30.v),
                          const Divider(),
                          SizedBox(height: 29.v),
                          _buildColumnFirstName(context),
                          SizedBox(height: 23.v),
                          _buildColumnLastName(context),
                          SizedBox(height: 23.v),
                          _buildColumnUsername(context),
                          SizedBox(height: 22.v),
                          _buildColumnBio(context),
                          SizedBox(height: 22.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Contact Info",
                              style: CustomTextStyles
                                  .labelLargeAbhayaLibreExtraBold,
                            ),
                          ),
                          SizedBox(height: 8.v),
                          CustomTextFormField(
                            controller: valueoneController,
                            hintText: "01124474341",
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.phone,
                          ),
                          SizedBox(height: 32.v),
                          CustomElevatedButton(
                            height: 48.v,
                            text: "Update",
                            margin: EdgeInsets.symmetric(horizontal: 17.h),
                            buttonStyle: CustomButtonStyles.fillPrimary,
                            buttonTextStyle:
                                CustomTextStyles.titleSmallPrimaryContainer,
                            onPressed: () {
                              //onTapUpdate(context);
                            },
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
        // bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Color(0XFFC3CCCC),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: AppbarTitle(
        text: "Account",
        margin: EdgeInsets.only(left: 8.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnFirstName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: Text(
              "First Name",
              style: CustomTextStyles.labelLargeAbhayaLibreExtraBold,
            ),
          ),
          SizedBox(height: 8.v),
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: CustomTextFormField(
              controller: firstNameController,
              hintText: "John Doe",
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnLastName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: Text(
              "Last Name",
              style: CustomTextStyles.labelLargeAbhayaLibreExtraBold,
            ),
          ),
          SizedBox(height: 7.v),
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: CustomTextFormField(
              controller: lastNameController,
              hintText: "John Doe",
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnUsername(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: Text(
              "username",
              style: CustomTextStyles.labelLargeAbhayaLibreExtraBold,
            ),
          ),
          SizedBox(height: 7.v),
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: CustomTextFormField(
              controller: userNameController,
              hintText: "john.doe",
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnBio(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: Text(
              "Bio",
              style: CustomTextStyles.labelLargeAbhayaLibreExtraBold,
            ),
          ),
          SizedBox(height: 8.v),
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: CustomTextFormField(
              controller: thisismybiovaluController,
              hintText: "This is my bio",
            ),
          )
        ],
      ),
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

  /// Navigates to the homeScreenContainerScreen when the action is triggered.
  onTapUpdate(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homeScreenContainerScreen);
  }
}
