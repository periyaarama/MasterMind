import 'package:flutter/material.dart';
import 'package:master_mind/screens/book_details_screen/widgets/userprofile3_item_widget.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
// import '../../widgets/custom_icon_button.dart';
import '../home_screen_page/home_screen_page.dart';
// import 'package:flutter/material.dart';
import 'package:master_mind/screens/crud_owner/book_detail_owner.dart';
import 'package:master_mind/screens/crud_owner/models/book.dart';
// import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class MyBooksPage extends StatefulWidget {
  const MyBooksPage({super.key});

  @override
  State<MyBooksPage> createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

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
          Map<String, dynamic> bookData = doc.data();
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
              return SafeArea(
                child: Scaffold(
                  body: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        SizedBox(height: 16.v),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5.v),
                              child: Column(
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgEllipse1,
                                    height: 90.adaptSize,
                                    width: 90.adaptSize,
                                    radius: BorderRadius.circular(
                                      45.h,
                                    ),
                                  ),
                                  SizedBox(height: 6.v),
                                  Text(
                                    "John Doe",
                                    style: theme.textTheme.headlineSmall,
                                  ),
                                  SizedBox(height: 5.v),
                                  Text(
                                    "This is my bio",
                                    style: theme.textTheme.labelSmall,
                                  ),
                                  SizedBox(height: 16.v),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgMdiLinkedin,
                                        height: 24.adaptSize,
                                        width: 24.adaptSize,
                                      ),
                                      CustomImageView(
                                        imagePath:
                                            ImageConstant.imgMdiInstagram,
                                        height: 24.adaptSize,
                                        width: 24.adaptSize,
                                        margin: EdgeInsets.only(left: 9.h),
                                      ),
                                      CustomImageView(
                                        imagePath:
                                            ImageConstant.imgPrimeTwitter,
                                        height: 24.adaptSize,
                                        width: 24.adaptSize,
                                        margin: EdgeInsets.only(left: 9.h),
                                      ),
                                      CustomImageView(
                                        imagePath:
                                            ImageConstant.imgIcBaselineFacebook,
                                        height: 24.adaptSize,
                                        width: 24.adaptSize,
                                        margin: EdgeInsets.only(left: 9.h),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 17.v),
                                  _buildRowBooks(context),
                                  SizedBox(height: 48.v),
                                  _buildRowBooks1(context),
                                  SizedBox(height: 17.v),
                                  // _buildUserProfile(context),
                                  // _buildRow(context),
                                  // SizedBox(height: 24.v),
                                  ..._buildBooksList(books),
                                ],
                              ),
                            ),
                          ),
                        )
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
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 172, 225, 159),
          )),
      title: Padding(
        padding: EdgeInsets.only(left: 16.h),
        child: Column(
          children: [
            AppbarTitle(
              text: "My Books",
              onTap: () {
                Navigator.of(context).pop();
              },
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
        builder: (context) => BookDetailsSellerScreen(book: book),
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

  /// Section Widget
  Widget _buildRowBooks(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.symmetric(
        horizontal: 36.h,
        vertical: 7.v,
      ),
      decoration: AppDecoration.fillErrorContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUilBook,
            height: 33.adaptSize,
            width: 33.adaptSize,
            margin: EdgeInsets.only(
              top: 9.v,
              bottom: 6.v,
            ),
          ),
          Container(
            width: 58.h,
            margin: EdgeInsets.only(
              left: 11.h,
              bottom: 2.v,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " Publishes\n       ",
                    style: theme.textTheme.titleSmall,
                  ),
                  TextSpan(
                    text: "35",
                    style: CustomTextStyles.headlineSmallAbhayaLibreExtraBold,
                  )
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const Spacer(
            flex: 53,
          ),
          Opacity(
            opacity: 0.3,
            child: SizedBox(
              height: 49.v,
              child: VerticalDivider(
                width: 1.h,
                thickness: 1.v,
                color: theme.colorScheme.secondaryContainer,
                indent: 7.h,
              ),
            ),
          ),
          const Spacer(
            flex: 46,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgUilHeadphonesAlt,
            height: 34.v,
            width: 33.h,
            margin: EdgeInsets.only(
              top: 7.v,
              bottom: 8.v,
            ),
          ),
          Container(
            width: 56.h,
            margin: EdgeInsets.only(
              left: 17.h,
              bottom: 4.v,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "    ",
                  ),
                  const TextSpan(
                    text: " ",
                  ),
                  TextSpan(
                    text: "Sells\n",
                    style: theme.textTheme.titleSmall,
                  ),
                  TextSpan(
                    text: "12.5 k",
                    style: CustomTextStyles.headlineSmallAbhayaLibreExtraBold,
                  )
                ],
              ),
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowBooks1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8.h,
        right: 24.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "My Books",
            style: theme.textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              top: 5.v,
              bottom: 4.v,
            ),
            child: Text(
              "4 Books",
              style: CustomTextStyles.labelLargeAbhayaLibreExtraBoldPrimary,
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //     left: 4.h,
          //     top: 5.v,
          //     bottom: 2.v,
          //   ),
          //   child: CustomIconButton(
          //     height: 16.adaptSize,
          //     width: 16.adaptSize,
          //     padding: EdgeInsets.all(1.h),
          //     child: CustomImageView(
          //       imagePath: ImageConstant.imgVector,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUserProfile(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.bookDetailsSellerScreen);
      },
      child: SizedBox(
        height: 270.v,
        child: ListView.separated(
          padding: EdgeInsets.only(left: 8.h),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 8.h,
            );
          },
          itemCount: 3,
          itemBuilder: (context, index) {
            return const Userprofile3ItemWidget();
          },
        ),
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homeScreenPage;
      case BottomBarEnum.Explore:
        return "/";
      case BottomBarEnum.Library:
        return "/";
      default:
        return "/";
    }
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
