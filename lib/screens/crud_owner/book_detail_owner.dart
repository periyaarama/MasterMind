import 'package:flutter/material.dart';
import 'package:master_mind/screens/crud_owner/models/book.dart';
import 'package:master_mind/screens/crud_owner/update_book.dart';
import 'package:master_mind/theme/custom_button_style.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../book_details_screen/widgets/chipviewpersona_item_widget.dart';

// ignore_for_file: must_be_immutable
class BookDetailsSellerScreen extends StatelessWidget {
  final Book book;

  BookDetailsSellerScreen({super.key, required this.book});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageStack(context),
                  SizedBox(height: 23.v),
                  Container(
                    width: 319.h,
                    margin: EdgeInsets.only(
                      left: 16.h,
                      right: 54.h,
                    ),
                    child: Text(
                      book.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 10.v),
                  Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      book.author,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  SizedBox(height: 8.v),
                  Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      book.title,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  SizedBox(height: 21.v),
                  CustomElevatedButton(
                    text: "${book.numberOfPages} pages",
                    margin: EdgeInsets.symmetric(horizontal: 16.h),
                    leftIcon: Container(
                      margin: EdgeInsets.only(right: 9.h),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgUilBook,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: 27.v),
                  _buildBookDetailsColumn(context),
                  SizedBox(height: 24.v),
                  _buildDeleteButton(context, book),
                  SizedBox(height: 24.v),
                  _buildUpdateButton(context, book),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildImageStack(BuildContext context) {
    return SizedBox(
      height: 333.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: book.imgUrl ?? ImageConstant.imgE50c016fB6a84184x128,
            height: 321.v,
            width: 390.h,
            alignment: Alignment.topCenter,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 333.v,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              decoration:
                  AppDecoration.gradientOnErrorContainerToOnErrorContainer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CustomImageView(
                    imagePath:
                        book.imgUrl ?? ImageConstant.imgE50c016fB6a84184x128,
                    height: 220.v,
                    width: 153.h,
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 6.v),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 277.v),
                      padding: EdgeInsets.symmetric(
                        horizontal: 33.h,
                        vertical: 16.v,
                      ),
                      decoration:
                          AppDecoration.fillOnSecondaryContainer.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath: book.imgUrl ??
                                ImageConstant.imgGgReadOnprimarycontainer,
                            height: 18.adaptSize,
                            width: 18.adaptSize,
                            margin: EdgeInsets.only(bottom: 4.v),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              bottom: 5.v,
                            ),
                            child: Text(
                              "1.7k",
                              style:
                                  CustomTextStyles.titleSmallSecondaryContainer,
                            ),
                          ),
                          Opacity(
                            opacity: 0.3,
                            child: Padding(
                              padding: EdgeInsets.only(left: 32.h),
                              child: SizedBox(
                                height: 24.v,
                                child: VerticalDivider(
                                  width: 1.h,
                                  thickness: 1.v,
                                  color: theme.colorScheme.secondaryContainer,
                                ),
                              ),
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgBasilStarOutline,
                            height: 15.adaptSize,
                            width: 15.adaptSize,
                            margin: EdgeInsets.only(
                              left: 48.h,
                              top: 3.v,
                              bottom: 6.v,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              top: 2.v,
                              bottom: 4.v,
                            ),
                            child: Text(
                              "4.8",
                              style:
                                  CustomTextStyles.titleSmallSecondaryContainer,
                            ),
                          ),
                          Opacity(
                            opacity: 0.3,
                            child: Padding(
                              padding: EdgeInsets.only(left: 47.h),
                              child: SizedBox(
                                height: 24.v,
                                child: VerticalDivider(
                                  width: 1.h,
                                  thickness: 1.v,
                                  color: theme.colorScheme.secondaryContainer,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 38.h,
                              top: 3.v,
                              bottom: 3.v,
                            ),
                            child: Text(
                              " ${book.price} RM",
                              style: theme.textTheme.titleSmall,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBookDetailsColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About this Book",
            style: CustomTextStyles
                .titleMediumAbhayaLibreExtraBoldOnPrimaryContainer,
          ),
          SizedBox(height: 8.v),
          Container(
            width: 351.h,
            margin: EdgeInsets.only(right: 6.h),
            child: Text(
              book.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall,
            ),
          ),
          SizedBox(height: 14.v),
          Wrap(
            runSpacing: 8.v,
            spacing: 8.h,
            children: book.genres
                .map((genre) => ChipviewpersonaItemWidget(text: genre))
                .toList(),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDeleteButton(BuildContext context, Book book) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: CustomElevatedButton(
        height: 48.v,
        width: double.infinity,
        text: "Delete Book",
        onPressed: () {
          _deleteBook(context, book);
        },
        buttonStyle: CustomButtonStyles.fillBlueGray_1,
        buttonTextStyle: theme.textTheme.titleSmall,
      ),
    );
  }

  Widget _buildUpdateButton(BuildContext context, Book book) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: CustomElevatedButton(
        height: 48.v,
        width: double.infinity,
        text: "Update Book",
        onPressed: () {
          _navigateToUpdateBook(context);
        },
        buttonStyle: CustomButtonStyles.fillBlueGray,
        buttonTextStyle: theme.textTheme.titleSmall,
      ),
    );
  }

  void _deleteBook(BuildContext context, Book book) async {
    // Show confirmation dialog
    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Book'),
        content: Text('Are you sure you want to delete "${book.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmDelete) {
      try {
        await FirebaseFirestore.instance
            .collection('books')
            .doc(book.documentId)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Book "${book.title}" deleted successfully')),
        );
        Navigator.pop(context); // Navigate back to the previous screen
      } catch (e) {
        print('Error deleting book: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete the book')),
        );
      }
    }
  }

  void _navigateToUpdateBook(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdatePage(book: book),
      ),
    );
  }
}
