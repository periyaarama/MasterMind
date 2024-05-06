import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../widgets/app_bar/appbar_title.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LogInEmailScreen extends StatefulWidget {
  LogInEmailScreen({super.key});

  @override
  State<LogInEmailScreen> createState() => _LogInEmailScreenState();
}

class _LogInEmailScreenState extends State<LogInEmailScreen> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController secondNameController = TextEditingController();

  TextEditingController bioController = TextEditingController();

  TextEditingController contactController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Loading state
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Retrieve data from the arguments passed from SignUpScreen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Retrieve data from the arguments passed from SignUpScreen
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
      if (args != null) {
        // Populate the form fields with data from SignUpScreen
        final name = args['name'] ?? '';
        final email = args['email'] ?? '';

        // Handle the name input conditionally
        _handleNameInput(name);
        emailController.text =
            email; // Use emailController to hold the email value
      }
    });
  }

  void _handleNameInput(String name) {
    // Split the name into parts
    List<String> nameParts = name.trim().split(' ');

    if (nameParts.length == 1) {
      // If there's only one name, assign it to `firstNameController`
      firstNameController.text = nameParts[0];
      secondNameController.clear();
    } else {
      // If there are multiple names, assign the first one to `firstNameController`
      // and the last one to `secondNameController`
      firstNameController.text = nameParts[0];
      secondNameController.text = nameParts.last;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            _buildMainContent(),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return SizedBox(
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
                  height: 105.h,
                  width: 105.h,
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
                      _buildFirstName(context),
                      SizedBox(height: 16.v),
                      _buildSecondName(context),
                      SizedBox(height: 16.v),
                      _buildBio(context),
                      SizedBox(height: 16.v),
                      _buildUsername(context),
                      SizedBox(height: 16.v),
                      _buildContact(context),
                      SizedBox(height: 16.v),
                      // _buildColumnMobileNo(context),
                      // SizedBox(height: 16.v),
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
  Widget _buildFirstName(BuildContext context) {
    return CustomTextFormField(
      controller: firstNameController,
      hintText: "First Name",
      textInputType: TextInputType.name,
    );
  }

  /// Section Widget
  Widget _buildSecondName(BuildContext context) {
    return CustomTextFormField(
      controller: secondNameController,
      hintText: "Last Name",
      textInputType: TextInputType.name,
    );
  }

  /// Section Widget
  Widget _buildBio(BuildContext context) {
    return CustomTextFormField(
      controller: bioController,
      textInputType: TextInputType.name,
      hintText: "Bio",
    );
  }

  /// Section Widget
  Widget _buildContact(BuildContext context) {
    return CustomTextFormField(
      controller: contactController,
      hintText: "Contact Number",
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.phone,
      //obscureText: true,
    );
  }

  /// Section Widget
  Widget _buildUsername(BuildContext context) {
    return CustomTextFormField(
      controller: usernameController,
      hintText: "username",
      //textInputAction: TextInputAction.done,
      textInputType: TextInputType.name,
      //obscureText: true,
    );
  }

  /// Section Widget
  // Widget _buildColumnMobileNo(BuildContext context) {
  //   return Container(
  //     width: 326.h,
  //     padding: EdgeInsets.symmetric(
  //       horizontal: 16.h,
  //       vertical: 15.v,
  //     ),
  //     decoration: AppDecoration.white.copyWith(
  //       borderRadius: BorderRadiusStyle.roundedBorder8,
  //     ),
  //     child: Text(
  //       "0128467586",
  //       style: theme.textTheme.titleSmall,
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildUpdate(BuildContext context) {
    return CustomElevatedButton(
      text: "Update",
      buttonTextStyle: CustomTextStyles.titleSmallPrimaryContainer,
      onPressed: () async {
        // Call the function to handle the form submission
        await _handleUpdate(context);
      },
    );
  }

  // Method to handle the update button press and navigate if data is valid
  Future<void> _handleUpdate(BuildContext context) async {
    // First, validate the form using the form key
    if (_formKey.currentState!.validate()) {
      // Set loading state to true
      setState(() {
        _isLoading = true;
      });

      // Collect data from text controllers
      final firstName = firstNameController.text;
      final lastName = secondNameController.text;
      final bio = bioController.text;
      final contactNumber = contactController.text;
      final username = usernameController.text;

      // Create a data map with the collected data
      final data = {
        'firstName': firstName,
        'lastName': lastName,
        'bio': bio,
        'contactNumber': contactNumber,
        'username': username,
      };

      try {
        // Add the data to the Firestore collection
        await _firestore.collection('users').add(data);

        // If data saving is successful, navigate to the next screen
        Navigator.of(context).pushNamed(AppRoutes.homeScreenContainerScreen);
      } catch (e) {
        print('Failed to save data: $e');
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save data'),
          ),
        );
        // You can also display an error message to the user in your UI if needed
      } finally {
        // Reset loading state to false
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // If form is not valid, you may want to display a message to the user
      print('Form validation failed');
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form validation failed'),
        ),
      );
    }
  }
}
