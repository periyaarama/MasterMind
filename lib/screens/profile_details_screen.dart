import 'package:master_mind/widgets/app_bar/appbar_title.dart';
import 'package:flutter/material.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../theme/custom_button_style.dart';
import '../core/app_export.dart';

// ProfileDetailsScreen as a StatefulWidget for managing state
class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileDetailsScreenState createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  // Text controllers for form fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  // FirestoreManager instance for managing Firestore interactions
  final FirestoreManager _firestoreManager = FirestoreManager();

  // Firebase Auth instance for authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Global key for form validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Loading state
  bool _isLoading = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    bioController.dispose();
    contactNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Fetch user data when the widget is initialized
    _fetchUserData();
  }

  // Function to fetch user data from Firestore
  Future<void> _fetchUserData() async {
    // Get the signed-in user's email
    final User? user = _auth.currentUser;
    if (user != null) {
      final String email = user.email ?? '';

      try {
        // Fetch the user's data from Firestore using FirestoreManager
        QuerySnapshot querySnapshot =
            await _firestoreManager.getDocumentByEmail('users', email);

        // Check if there is exactly one matching document
        if (querySnapshot.docs.isNotEmpty) {
          // Get the document data
          final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
          final data = documentSnapshot.data() as Map<String, dynamic>?;

          // Update text controllers with retrieved data
          setState(() {
            firstNameController.text = data?['firstName'] ?? '';
            lastNameController.text = data?['lastName'] ?? '';
            userNameController.text = data?['username'] ?? '';
            bioController.text = data?['bio'] ?? '';
            contactNumberController.text = data?['contactNumber'] ?? '';
          });
        } else {
          // Handle case where no matching document was found
          print('No matching document found with email: $email');
        }
      } catch (e) {
        // Handle errors
        print('Error fetching user data: $e');
      }
    }
  }

// Function to update user profile
  Future<void> _updateUserProfile() async {
    // Validate the form
    if (_formKey.currentState?.validate() ?? false) {
      // Set loading state to true
      setState(() {
        _isLoading = true;
      });

      // Fetch updated data from text controllers
      final Map<String, dynamic> updatedData = {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'username': userNameController.text.trim(),
        'bio': bioController.text.trim(),
        'contactNumber': contactNumberController.text.trim(),
      };

      // Get the signed-in user's email
      final User? user = _auth.currentUser;
      if (user != null) {
        final String email = user.email ?? '';

        try {
          // Update the document in Firestore based on the user's email
          await _firestoreManager.updateDocumentInCollection(
              'users', email, updatedData);

          // Provide feedback to the user
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully.'),
              duration: Duration(seconds: 3),
            ),
          );
        } catch (e) {
          // Handle errors and provide feedback to the user
          print('Failed to update profile: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to update profile. Please try again.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
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
                      // Build other form fields here, e.g., _buildProfileImage()
                      _buildColumnFirstName(context),
                      SizedBox(height: 23.v),
                      _buildColumnLastName(context),
                      SizedBox(height: 23.v),
                      _buildColumnUsername(context),
                      SizedBox(height: 22.v),
                      _buildColumnBio(context),
                      SizedBox(height: 22.v),
                      _buildColumnContactNumber(context),
                      SizedBox(height: 32.v),
                      CustomElevatedButton(
                        height: 48.v,
                        text: "Update",
                        margin: EdgeInsets.symmetric(horizontal: 17.h),
                        buttonStyle: CustomButtonStyles.fillPrimary,
                        buttonTextStyle:
                            CustomTextStyles.titleSmallPrimaryContainer,
                        onPressed: () async {
                          await _updateUserProfile();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading) // Show circular progress indicator while loading
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  // Function to build the app bar
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
        text: 'Account',
        // margin: EdgeInsets.only(left: 8.h),
      ),
    );
  }

  Widget _buildColumnFirstName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("First Name",
              style: CustomTextStyles.labelLargeAbhayaLibreExtraBold),
          SizedBox(height: 8.v),
          CustomTextFormField(
            controller: firstNameController,
            hintText: firstNameController.text,
          ),
        ],
      ),
    );
  }

  Widget _buildColumnLastName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Last Name",
              style: CustomTextStyles.labelLargeAbhayaLibreExtraBold),
          SizedBox(height: 7.v),
          CustomTextFormField(
            controller: lastNameController,
            hintText: lastNameController.text,
          ),
        ],
      ),
    );
  }

  Widget _buildColumnUsername(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Username",
              style: CustomTextStyles.labelLargeAbhayaLibreExtraBold),
          SizedBox(height: 7.v),
          CustomTextFormField(
            controller: userNameController,
            hintText: userNameController.text,
          ),
        ],
      ),
    );
  }

  Widget _buildColumnBio(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Bio", style: CustomTextStyles.labelLargeAbhayaLibreExtraBold),
          SizedBox(height: 8.v),
          CustomTextFormField(
            controller: bioController,
            hintText: bioController.text,
          ),
        ],
      ),
    );
  }

  Widget _buildColumnContactNumber(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Contact Number",
              style: CustomTextStyles.labelLargeAbhayaLibreExtraBold),
          SizedBox(height: 8.v),
          CustomTextFormField(
            controller: contactNumberController,
            hintText: contactNumberController.text,
          ),
        ],
      ),
    );
  }
}
