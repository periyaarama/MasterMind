//account_screen.dart

import 'package:flutter/material.dart';
import 'package:master_mind/screens/crud_owner/my_books.dart';
import 'package:master_mind/screens/payment/credit_card_payment_premium.dart';
import 'package:master_mind/widgets/app_bar/appbar_title.dart';

import '../core/app_export.dart';
import '../theme/custom_button_style.dart';
//import '../widgets/app_bar/appbar_leading_image.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/custom_outlined_button.dart';
import 'crud_owner/upload_page.dart';
import 'home_screen_page/home_screen_page.dart';

// ignore_for_file: must_be_immutable
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  final user = FirebaseAuth.instance.currentUser!;

  final _auth = FirebaseAuth.instance;

  final _firestoreManager = FirestoreManager();

  bool _isLoading = false;

  Future<bool> _isUserPremium() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return false;
    }

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('premium')
          .where('userid', isEqualTo: user.uid)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Failed to check premium status: $e');
      return false;
    }
  }

  void _showNotPremiumAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Not a Premium Member'),
          content:
              Text('You need to be a premium member to access this feature.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteUserProfile() async {
    setState(() {
      _isLoading = true;
    });
    // Get the signed-in user's email
    final User? user = _auth.currentUser;
    if (user != null) {
      final String email = user.email ?? '';

      try {
        // Update the document in Firestore based on the user's email
        await _firestoreManager.deleteDocumentFromCollection(
          'users',
          email,
        );

        // Sign out the user from Firebase Authentication
        // await FirebaseAuth.instance.signOut();

        // Delete the user from Firebase Authentication
        await user.delete();
        // Provide feedback to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile deleted successfully.'),
            duration: Duration(seconds: 3),
          ),
        );
      } catch (e) {
        // Handle errors and provide feedback to the user
        print('Failed to delete profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to delete profile. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
      } finally {
        // Set loading state to false
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            SizedBox(
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
                            _buildRowUilCreditCard(context, payment: "Payment"),
                            _buildRowUilCreditCard(context,
                                payment: "Subscription"),
                            const Divider(),
                            SizedBox(height: 23.v),
                            _buildRowUilCreditCard(context, payment: "FAQs"),
                            _buildRowUilCreditCard(context,
                                payment: "Logout",
                                imageconstant: ImageConstant.imgUilSignout,
                                onTap: () {
                              FirebaseAuth.instance.signOut();
                            }),
                            _buildRowUilCreditCard(context,
                                payment: "Delete Account",
                                imageconstant: ImageConstant.imgMdiDelete,
                                onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete your Account?'),
                                    content: const Text(
                                        'Do You Want to Delete Your Account'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(),
                                        ),
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          await _deleteUserProfile();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
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
                              buttonStyle: CustomButtonStyles.fillPrimary,
                              buttonTextStyle:
                                  CustomTextStyles.titleSmallPrimaryContainer,
                            ),
                            SizedBox(height: 20.v), // Added space

                            CustomElevatedButton(
                              // Add Book button
                              height: 64.v,
                              text: "Add Book",
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });

                                bool isPremium = await _isUserPremium();

                                setState(() {
                                  _isLoading = false;
                                });

                                if (isPremium) {
                                  // Navigate to the page where users can upload their book
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const UploadPage()));
                                } else {
                                  _showNotPremiumAlert();
                                }
                              },
                              buttonStyle: CustomButtonStyles.fillPrimary,
                              buttonTextStyle:
                                  CustomTextStyles.titleSmallPrimaryContainer,
                            ),
                            SizedBox(height: 20.v), // Added space

                            CustomElevatedButton(
                              // View My Books button
                              height: 64.v,
                              text: "View My Books",
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });

                                bool isPremium = await _isUserPremium();

                                setState(() {
                                  _isLoading = false;
                                });

                                if (isPremium) {
                                  // Navigate to the page where users can view their books
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const MyBooksPage()));
                                } else {
                                  _showNotPremiumAlert();
                                }
                              },
                              buttonStyle: CustomButtonStyles.fillPrimary,
                              buttonTextStyle:
                                  CustomTextStyles.titleSmallPrimaryContainer,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
          ],
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
          color: Color.fromARGB(255, 9, 197, 122),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: AppbarTitle(
        text: 'Home',
        // margin: EdgeInsets.only(left: 8.h),
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
          text: "premium",
          decoration: BoxDecoration(color: Color.fromARGB(255, 144, 228, 147)),
          margin: EdgeInsets.symmetric(vertical: 21.v),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => const CreditCardPaymentPremium()));
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
