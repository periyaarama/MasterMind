import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
//import 'package:master_mind/core/utils/image_constant.dart';


// ignore_for_file: must_be_immutable
class SignUpScreen extends StatefulWidget {

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
  
class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameEditTextController = TextEditingController();

  TextEditingController emailEditTextController = TextEditingController();

  TextEditingController passwordEditTextController = TextEditingController();

  final Auth auth = Auth();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: null,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SizedBox(
            height: 811.v,
            width: 394.h,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgRectangle363,
                  height: 803.v,
                  width: 365.h,
                  alignment: Alignment.centerLeft,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 8.v),
                    child: Container(
                      height: 490.v,
                      width: 378.h,
                      margin: EdgeInsets.only(bottom: 110.v),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 33.h),
                              child: Text(
                                "Sign up",
                                style: theme.textTheme.headlineLarge,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.only(left: 17.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.h,
                                vertical: 24.v,
                              ),
                              decoration:
                                  AppDecoration.fillPrimaryContainer.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder12,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      width: 216.h,
                                      child: Text(
                                        "Looks like you don’t have an account.\nLet’s create a new account for you.",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: CustomTextStyles
                                            .titleSmallBluegray50,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 21.v),
                                  _buildNameEditText(context),
                                  SizedBox(height: 14.v),
                                  _buildEmailEditText(context),
                                  SizedBox(height: 14.v),
                                  _buildPasswordEditText(context),
                                  SizedBox(height: 13.v),
                                  Container(
                                    width: 317.h,
                                    margin: EdgeInsets.only(right: 9.h),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                "By selecting Create Account below, I agree to ",
                                            style: CustomTextStyles
                                                .titleSmallBluegray50_1,
                                          ),
                                          TextSpan(
                                            text: "Terms of Service",
                                            style: CustomTextStyles
                                                .titleSmallPrimary_1,
                                          ),
                                          TextSpan(
                                            text: " & ",
                                            style: CustomTextStyles
                                                .titleSmallBluegray50_1,
                                          ),
                                          TextSpan(
                                            text: "Privacy Policy",
                                            style: CustomTextStyles
                                                .titleSmallPrimary_1,
                                          )
                                        ],
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(height: 13.v),
                                  _buildCreateAccountButton(context),
                                  SizedBox(height: 23.v),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          AppRoutes.logInEmailOneScreen);
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Already have an account? ",
                                            style: CustomTextStyles
                                                .titleSmallBluegray50_1,
                                          ),
                                          TextSpan(
                                            text: "Log in",
                                            style: CustomTextStyles
                                                .titleSmallPrimary_1,
                                          )
                                        ],
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ],
                              ),
                            ),
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
      ),
    );
  }

  /// Section Widget
  Widget _buildNameEditText(BuildContext context) {
    return CustomTextFormField(
      controller: nameEditTextController,
      hintText: "Name",
    );
  }

  /// Section Widget
  Widget _buildEmailEditText(BuildContext context) {
    return CustomTextFormField(
      controller: emailEditTextController,
      hintText: "Email",
      textInputType: TextInputType.emailAddress,
    );
  }

/// Section Widget
  Widget _buildPasswordEditText(BuildContext context) {
    return CustomTextFormField(
      controller: passwordEditTextController,
      hintText: "Password",
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      obscureText: !isPasswordVisible, // Toggle password visibility based on this variable
      suffix: GestureDetector(
        onTap: () {
          // Toggle the visibility of the password when the eye icon is tapped
          setState(() {
            isPasswordVisible = !isPasswordVisible;
          });
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(30.h, 12.v, 16.h, 13.v),
          child: CustomImageView(
            // Change the eye icon based on the visibility state
             imagePath: isPasswordVisible ? ImageConstant.imgEyeOff : ImageConstant.imgEye, // Uncomment this line if using images
            height: 24.adaptSize,
            width: 24.adaptSize,
          ),
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 49.v,
      ),
      contentPadding: EdgeInsets.only(
        left: 16.h,
        top: 16.v,
        bottom: 16.v,
      ),
    );
  }


  /// Section Widget
  Widget _buildCreateAccountButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Create Account",
      buttonTextStyle: CustomTextStyles.titleSmallPrimaryContainer,
      onPressed: () async {
        // Get the email and password from the text controllers
        String email = emailEditTextController.text.trim();
        String password = passwordEditTextController.text.trim();

        // Validate form fields (e.g., check for empty values)
        if (_formKey.currentState?.validate() ?? false) {
          // Call the signUp function from Auth class
          User? user = await auth.signUp(email, password);

          if (user != null) {
            // Sign up successful, navigate to the next screen or show a success message
            Navigator.pushNamed(context, AppRoutes.logInEmailScreen);
          } else {
            // Sign up failed, show an error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sign up failed. Please try again.'),
              ),
            );
          }
        }
      },
    );
  }
}
