import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../widgets/app_bar/appbar_title.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LogInEmailScreen extends StatelessWidget {
  LogInEmailScreen({super.key});

  TextEditingController radio27ValueController = TextEditingController();

  TextEditingController biloveBooksValueController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController languageController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.h,
                  vertical: 4.v,
                ),
                child: Column(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgEllipse2,
                      height: 105.v,
                      width: 111.h,
                      radius: BorderRadius.circular(
                        52.h,
                      ),
                    ),
                    SizedBox(height: 11.v),
                    _buildEditProfile(context),
                    SizedBox(height: 24.v),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.h,
                        vertical: 24.v,
                      ),
                      decoration: AppDecoration.fillPrimaryContainer.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder12,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildRadio27Value(context),
                          SizedBox(height: 16.v),
                          _buildBiloveBooksValue(context),
                          SizedBox(height: 16.v),
                          _buildEmail(context),
                          SizedBox(height: 16.v),
                          _buildLanguage(context),
                          SizedBox(height: 16.v),
                          _buildColumnMobileNo(context),
                          SizedBox(height: 16.v),
                          _buildUpdate(context),
                          SizedBox(height: 16.v)
                        ],
                      ),
                    ),
                    SizedBox(height: 5.v)
                  ],
                ),
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
      centerTitle: true,
      title: AppbarTitle(
        text: "User Profile",
      ),
    );
  }

  /// Section Widget
  Widget _buildEditProfile(BuildContext context) {
    return CustomElevatedButton(
      height: 34.v,
      width: 100.h,
      text: "Edit Profie ",
      buttonTextStyle: CustomTextStyles.titleSmallOnPrimary,
    );
  }

  /// Section Widget
  Widget _buildRadio27Value(BuildContext context) {
    return CustomTextFormField(
      controller: radio27ValueController,
      hintText: "Readio27",
    );
  }

  /// Section Widget
  Widget _buildBiloveBooksValue(BuildContext context) {
    return CustomTextFormField(
      controller: biloveBooksValueController,
      hintText: "BI love books",
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
      controller: emailController,
      hintText: "readio@gmail.com ",
    );
  }

  /// Section Widget
  Widget _buildLanguage(BuildContext context) {
    return CustomTextFormField(
      controller: languageController,
      hintText: "+++++++++++",
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      obscureText: true,
    );
  }

  /// Section Widget
  Widget _buildColumnMobileNo(BuildContext context) {
    return Container(
      width: 326.h,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 15.v,
      ),
      decoration: AppDecoration.white.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Text(
        "0128467586",
        style: theme.textTheme.titleSmall,
      ),
    );
  }

  /// Section Widget
  Widget _buildUpdate(BuildContext context) {
    return CustomElevatedButton(
      text: "Update",
      buttonTextStyle: CustomTextStyles.titleSmallPrimaryContainer,
      onPressed: () {
        Navigator.of(context).pushNamed(AppRoutes.homeScreenContainerScreen);
      },
    );
  }
}
