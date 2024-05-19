import 'package:flutter/material.dart';
import 'package:master_mind/screens/book_details_screen/widgets/chipviewpersona_item_widget.dart';
import 'package:master_mind/screens/crud_owner/models/book.dart';
import 'package:master_mind/screens/crud_owner/update_book.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class BookDetailsScreen extends StatelessWidget {
  final Book book;

  // ignore: use_key_in_widget_constructors
  BookDetailsScreen({
    Key? key,
    required this.book,
  });

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Book Details'),
        ),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                children: [
                  _buildProjectRow(context),
                  SizedBox(height: 21.v),
                  _buildAboutThisColumn(context),
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
  Widget _buildProjectRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 319.h,
            child: Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 10.v),
          Text(
            book.author,
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 8.v),
          Text(
            book.description,
            style: theme.textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAboutThisColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About this Book",
            style: theme.textTheme.titleMedium,
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
