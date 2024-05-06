import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../widgets/app_bar/appbar_title.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';

class LogInEmailScreen extends StatefulWidget {
  LogInEmailScreen({super.key});

  @override
  _LogInEmailScreenState createState() => _LogInEmailScreenState();
}

class _LogInEmailScreenState extends State<LogInEmailScreen> {
  final TextEditingController radio27ValueController =
      TextEditingController(); // First Name
  final TextEditingController biloveBooksValueController =
      TextEditingController(); // Last Name
  final TextEditingController emailController = TextEditingController(); // Bio
  final TextEditingController contactController =
      TextEditingController(); // Contact Number
  final TextEditingController usernameController =
      TextEditingController(); // Username

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Reference to Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Loading state
  bool _isLoading = false;

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
              Center(
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
                _buildEditProfile(),
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
                      _buildRadio27Value(),
                      SizedBox(height: 16.v),
                      _buildBiloveBooksValue(),
                      SizedBox(height: 16.v),
                      _buildEmail(),
                      SizedBox(height: 16.v),
                      _buildUsername(),
                      SizedBox(height: 16.v),
                      _buildContact(),
                      SizedBox(height: 16.v),
                      _buildUpdate(context),
                      SizedBox(height: 16.v),
                    ],
                  ),
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(
        text: "User Profile",
      ),
    );
  }

  Widget _buildEditProfile() {
    return CustomElevatedButton(
      height: 34.v,
      width: 100.h,
      text: "Edit Profile",
      buttonTextStyle: CustomTextStyles.titleSmallOnPrimary,
    );
  }

  Widget _buildRadio27Value() {
    return CustomTextFormField(
      controller: radio27ValueController,
      hintText: "First Name",
      textInputType: TextInputType.name,
    );
  }

  Widget _buildBiloveBooksValue() {
    return CustomTextFormField(
      controller: biloveBooksValueController,
      hintText: "Last Name",
      textInputType: TextInputType.name,
    );
  }

  Widget _buildEmail() {
    return CustomTextFormField(
      controller: emailController,
      hintText: "Bio",
      textInputType: TextInputType.text,
    );
  }

  Widget _buildUsername() {
    return CustomTextFormField(
      controller: usernameController,
      hintText: "Username",
      textInputType: TextInputType.name,
    );
  }

  Widget _buildContact() {
    return CustomTextFormField(
      controller: contactController,
      hintText: "Contact Number",
      textInputType: TextInputType.phone,
    );
  }

  Widget _buildUpdate(BuildContext context) {
    return CustomElevatedButton(
      text: "Update",
      buttonTextStyle: CustomTextStyles.titleSmallPrimaryContainer,
      onPressed: () async {
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
      final firstName = radio27ValueController.text;
      final lastName = biloveBooksValueController.text;
      final bio = emailController.text;
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
        print('Data saved successfully!');

        // If data saving is successful, navigate to the next screen
        Navigator.of(context).pushNamed(AppRoutes.homeScreenContainerScreen);
      } catch (e) {
        print('Failed to save data: $e');
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
    }
  }
}
