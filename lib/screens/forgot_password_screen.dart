import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
//import 'package:master_mind/core/utils/image_constant.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailEditTextController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance; // Firebase auth instance

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                                "Forgot Password",
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
                                        "Please enter your email address. We will send you a password reset link.",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: CustomTextStyles
                                            .titleSmallBluegray50,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 21.v),
                                  _buildEmailEditText(context),
                                  SizedBox(height: 14.v),
                                  _buildResetPasswordButton(context),
                                  SizedBox(height: 13.v),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Go back to Log in",
                                        style: CustomTextStyles
                                            .titleSmallPrimary_1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Email input field
  Widget _buildEmailEditText(BuildContext context) {
    return CustomTextFormField(
      controller: emailEditTextController,
      hintText: "Email",
      textInputType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your email";
        } else if (!value.contains('@')) {
          return "Please enter a valid email address";
        }
        return null;
      },
    );
  }

  /// Password reset button
  Widget _buildResetPasswordButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Send Password Reset Email",
      buttonTextStyle: CustomTextStyles.titleSmallPrimaryContainer,
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          String email = emailEditTextController.text.trim();
          try {
            // Send password reset email using Firebase Authentication
            await auth.sendPasswordResetEmail(email: email);
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Password reset email sent. Please check your email inbox.'),
              ),
            );
            // Optionally navigate back to the login screen or pop the current screen
          } catch (e) {
            // Handle any errors, such as invalid email or network issues
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Failed to send password reset email. Please try again.'),
              ),
            );
          }
        }
      },
    );
  }
}
