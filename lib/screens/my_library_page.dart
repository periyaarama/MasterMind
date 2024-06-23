import 'package:flutter/material.dart';
import 'package:master_mind/screens/book_details_screen/book_details_screen_v.dart';
import 'package:master_mind/screens/book_details_screen/widgets/userprofile3_item_widget.dart';
import 'package:master_mind/screens/crud_owner/models/book.dart';

import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';

class MyLibraryPage extends StatelessWidget {
  const MyLibraryPage({super.key});

  Future<List<DocumentSnapshot>> fetchBooksByCollection(String type) async {
    // Get the current user ID
    final userId = FirebaseAuth.instance.currentUser?.uid;

    // Fetch the documents from the specified collection
    final querySnapshot = await FirebaseFirestore.instance
        .collection(type)
        .where('userId', isEqualTo: userId)
        .get();

    // Extract the book IDs
    List<String> bookIds =
        querySnapshot.docs.map((doc) => doc['bookId'] as String).toList();

    // Fetch the books using the book IDs
    final booksCollection = FirebaseFirestore.instance.collection('books');
    List<DocumentSnapshot> bookDocs = [];

    for (String bookId in bookIds) {
      final bookDoc = await booksCollection.doc(bookId).get();
      if (bookDoc.exists) {
        bookDocs.add(bookDoc);
      }
    }

    return bookDocs;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 4.v),
              child: Column(
                children: [
                  SizedBox(height: 45.v),
                  _buildRow(context),
                  SizedBox(height: 30.v),
                  _buildTypeSection(context, "favs"),
                  SizedBox(height: 30.v),
                  _buildTypeSection(context, "purchase"),
                  SizedBox(height: 30.v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildRowCheck(context,
              isChecked: ImageConstant.imgUilBookmarkOnprimary,
              label: "Saved Books"),
          // _buildRowCheckedOne(
          //   context,
          //   isChecked: ImageConstant.imgIcons,
          //   label: "In Progress",
          // ),
          // _buildRowCheckedOne(
          //   context,
          //   isChecked: ImageConstant.imgChecked,
          //   label: "Completed",
          // )
        ],
      ),
    );
  }

  Widget _buildRowCheck(
    BuildContext context, {
    required String isChecked,
    required String label,
  }) {
    return Container(
      width: 123.h,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.fillGreen.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImageView(
            imagePath: isChecked,
            height: 18.adaptSize,
            width: 18.adaptSize,
          ),
          Text(
            label,
            style: CustomTextStyles.titleSmallAlegreyaSansOnPrimary,
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildRowCheckedOne(
    BuildContext context, {
    required String isChecked,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.outlineOnPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: isChecked,
            height: 18.adaptSize,
            width: 18.adaptSize,
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              label,
              style: CustomTextStyles.titleSmallAlegreyaSans.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Padding(
        padding: EdgeInsets.only(left: 16.h),
        child: Column(
          children: [
            AppbarTitle(
              text: "My Library",
            ),
            SizedBox(height: 2.v),
            SizedBox(
              width: 110.h,
              child: Divider(
                color: appTheme.green100,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSection(BuildContext context, String type) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 24.h),
            child: _buildSectionHeader(context, type),
          ),
          SizedBox(height: 34.v),
          SizedBox(
            height: 260.v,
            child: FutureBuilder<List<DocumentSnapshot>>(
              future: fetchBooksByCollection(type),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No books found.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 1.h);
                    },
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var bookSnapshot = snapshot.data![index];
                      var book = Book.fromSnapshot(bookSnapshot);
                      return InkWell(
                        onTap: () {
                          // Navigator.of(context).pushNamed(
                          //   AppRoutes.bookDetailsScreen,
                          //   arguments: book.id,
                          // );
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => BookDetailsScreenV(
                                    book: book,
                                  )));
                        },
                        child: Userprofile3ItemWidget(book: book),
                        // BookItemWidget(book: bookSnapshot),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String type) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type == 'favs' ? 'favourites' : type,
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.onError.withOpacity(1),
          ),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(top: 3.v, bottom: 5.v),
          child: Text(
            "Show all",
            style: CustomTextStyles.labelLargeAbhayaLibreExtraBoldGreen100
                .copyWith(color: appTheme.green100),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 4.h, top: 3.v, bottom: 4.v),
          child: CustomIconButton(
            height: 16.adaptSize,
            width: 16.adaptSize,
            padding: EdgeInsets.all(1.h),
            child: CustomImageView(imagePath: ImageConstant.imgVector),
          ),
        )
      ],
    );
  }
}
