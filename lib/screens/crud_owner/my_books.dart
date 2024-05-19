import 'package:flutter/material.dart';
import 'package:master_mind/screens/crud_owner/book_detail_owner.dart';
import 'package:master_mind/screens/crud_owner/models/book.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart'; // ignore_for_file: must_be_immutable

class MyBooksPage extends StatefulWidget {
  const MyBooksPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyBooksPageState createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Book>> _fetchBooksStream() {
    // Retrieve the current user's email
    final currentUser = FirebaseAuth.instance.currentUser;
    final ownerEmail = currentUser?.email;

    if (ownerEmail != null) {
      return _firestore
          .collection('books')
          .where('ownerEmail', isEqualTo: ownerEmail)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          Map<String, dynamic> bookData = doc.data() as Map<String, dynamic>;
          return Book.fromMap(bookData, doc.id);
        }).toList();
      });
    } else {
      return Stream.value([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: StreamBuilder<List<Book>>(
          stream: _fetchBooksStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error fetching books.'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No books found.'));
            } else {
              List<Book> books = snapshot.data!;
              return SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 11.v),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 13.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRow(context),
                        SizedBox(height: 24.v),
                        ..._buildBooksList(books),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Padding(
        padding: EdgeInsets.only(left: 16.h),
        child: Column(
          children: [
            AppbarTitle(
              text: "My Books",
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

  Widget _buildRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
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
                  imagePath: ImageConstant.imgUilBookmarkOnprimary,
                  height: 18.adaptSize,
                  width: 18.adaptSize,
                ),
                Text(
                  " ",
                  style: CustomTextStyles.titleSmallAlegreyaSansOnPrimary,
                )
              ],
            ),
          ),
          _buildRowCheckedOne(
            context,
            isChecked: ImageConstant.imgIcons,
            label: " ",
          ),
          _buildRowCheckedOne(
            context,
            isChecked: ImageConstant.imgChecked,
            label: " ",
          )
        ],
      ),
    );
  }

  List<Widget> _buildBooksList(List<Book> books) {
    List<Widget> widgets = [];
    for (var i = 0; i < books.length; i += 2) {
      widgets.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 16.v),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (i < books.length)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _navigateToBookDetails(books[i]);
                    },
                    child: _buildBookItem(context, books[i]),
                  ),
                ),
              if (i + 1 < books.length)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _navigateToBookDetails(books[i + 1]);
                    },
                    child: _buildBookItem(context, books[i + 1]),
                  ),
                ),
            ],
          ),
        ),
      );
    }
    return widgets;
  }

  void _navigateToBookDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(book: book),
      ),
    );
  }

  Widget _buildBookItem(BuildContext context, Book book) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: book.imgUrl ?? ImageConstant.imagePath,
            height: 254.v,
            width: 175.h,
          ),
          SizedBox(height: 16.v),
          Text(
            book.title,
            style: CustomTextStyles.titleSmallAlegreyaSans,
          ),
          SizedBox(height: 1.v),
          Text(
            book.author,
            style: CustomTextStyles.labelLargeAbhayaLibreExtraBold,
          ),
          SizedBox(height: 8.v),
          SizedBox(
            width: 160.h,
            child: Text(
              book.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.labelMediumPrimary,
            ),
          ),
          SizedBox(height: 14.v),
          CustomElevatedButton(
            height: 24.v,
            width: 42.h,
            text: book.imgUrl ?? 'N/A',
            leftIcon: Container(
              margin: EdgeInsets.only(right: 4.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgIconsOnprimarycontainer,
                height: 16.adaptSize,
                width: 16.adaptSize,
              ),
            ),
            buttonStyle: CustomButtonStyles.fillGray,
            buttonTextStyle: CustomTextStyles.labelMediumOnPrimaryContainer,
          )
        ],
      ),
    );
  }

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
}
