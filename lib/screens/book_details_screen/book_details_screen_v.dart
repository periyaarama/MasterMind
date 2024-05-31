import 'package:flutter/material.dart';
import 'package:master_mind/screens/crud_owner/models/book.dart';
import 'package:master_mind/screens/crud_owner/pdf_viewer_page_mob.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
// import '../../widgets/custom_icon_button.dart';
import 'widgets/chipviewpersona_item_widget.dart';
import 'widgets/userprofile3_item_widget.dart';

// ignore_for_file: must_be_immutable
class BookDetailsScreenV extends StatefulWidget {
  final Book book;
  const BookDetailsScreenV({super.key, required this.book});

  @override
  State<BookDetailsScreenV> createState() => _BookDetailsScreenVState();
}

class _BookDetailsScreenVState extends State<BookDetailsScreenV> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  bool _isBookFaved = false;

  Future<void> toggleFavoriteStatus(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final bookId = widget.book.documentId;
    final bookTitle = widget.book.title;

    if (user != null) {
      final favsCollection = FirebaseFirestore.instance.collection('favs');
      final docSnapshot = await favsCollection
          .where('userId', isEqualTo: user.uid)
          .where('bookId', isEqualTo: bookId)
          .get();

      if (docSnapshot.docs.isEmpty) {
        // Add to favs
        await favsCollection.add({
          'userId': user.uid,
          'bookId': bookId,
          'added_date': FieldValue.serverTimestamp(),
        });
        setState(() {
          _isBookFaved = true;
        });
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$bookTitle is added to Favourite List'),
            duration: const Duration(seconds: 3),
          ),
        );
      } else {
        // Remove from favs
        await favsCollection.doc(docSnapshot.docs.first.id).delete();
        setState(() {
          _isBookFaved = false;
        });
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$bookTitle is removed from Favourite List'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> togglePurchaseStatus(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final bookId = widget.book.documentId;

    if (user != null) {
      final purchaseCollection =
          FirebaseFirestore.instance.collection('purchase');
      final bookDoc =
          FirebaseFirestore.instance.collection('books').doc(bookId);
      final docSnapshot = await purchaseCollection
          .where('userId', isEqualTo: user.uid)
          .where('bookId', isEqualTo: bookId)
          .get();

      if (docSnapshot.docs.isEmpty) {
        // Show confirmation dialog before adding to purchase
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Purchase'),
              content:
                  const Text('Are you sure you want to purchase this book?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    // Add to purchase
                    await purchaseCollection.add({
                      'userId': user.uid,
                      'bookId': bookId,
                      'purchase_date': FieldValue.serverTimestamp(),
                    });

                    // Update isPurchase field in books collection
                    await bookDoc.update({'isPurchase': true});

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'The purchase for ${widget.book.title} is Successful')));
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      } else {
        // Show confirmation dialog before removing from purchase
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Restore Purchase'),
              content:
                  const Text('Are you sure you want to restore this purchase?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    // Remove from purchase
                    await purchaseCollection
                        .doc(docSnapshot.docs.first.id)
                        .delete();

                    // Update isPurchase field in books collection
                    await bookDoc.update({'isPurchase': false});

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'The purchase for ${widget.book.title} is restored')));
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                children: [
                  _buildImageStack(context),
                  SizedBox(height: 23.v),
                  _buildProjectRow(context),
                  SizedBox(height: 21.v),
                  CustomElevatedButton(
                    height: 40.v,
                    text: "${widget.book.numberOfPages} pages",
                    margin: EdgeInsets.symmetric(horizontal: 16.h),
                    leftIcon: Container(
                      margin: EdgeInsets.only(right: 9.h),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgUilbook,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                      ),
                    ),
                    buttonStyle: CustomButtonStyles.fillBlueGray,
                    buttonTextStyle: theme.textTheme.titleSmall!,
                  ),
                  SizedBox(height: 27.v),
                  _buildAboutThisColumn(context),
                  // SizedBox(height: 49.v),
                  // _buildChaptersColumn(context),
                  SizedBox(height: 26.v),
                  _buildFinalSummaryColumn(context),
                  SizedBox(height: 30.v),
                  _buildSimilarBooksColumn(context)
                ],
              ),
            ),
          ),
        ),
        // bottomNavigationBar: _buildBottomBar(context),
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
            imagePath:
                widget.book.imgUrl ?? ImageConstant.imgE50c016fB6a84184x128,
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
                  AppDecoration.gradientOnPrimaryContainerToOnPrimaryContainer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CustomImageView(
                    imagePath: widget.book.imgUrl ??
                        ImageConstant.imgE50c016fB6a84184x128,
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
                        horizontal: 43.h,
                        vertical: 16.v,
                      ),
                      decoration: AppDecoration.fillBlueGray.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   width: 55.h,
                          // ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PDFViewerPage(
                                    pdfUrl: widget.book.pdfUrl!,
                                  ),
                                ));
                              },
                              child: Row(
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgBiPlayFill,
                                    height: 16.adaptSize,
                                    width: 16.adaptSize,
                                    margin: EdgeInsets.only(
                                      top: 2.v,
                                      bottom: 5.v,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 9.h,
                                      top: 1.v,
                                      bottom: 5.v,
                                    ),
                                    child: Text(
                                      "Read",
                                      style: theme.textTheme.titleSmall,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          Opacity(
                            opacity: 0.3,
                            child: Padding(
                              padding: EdgeInsets.only(left: 43.h),
                              child: SizedBox(
                                height: 24.v,
                                child: VerticalDivider(
                                  width: 1.h,
                                  thickness: 1.v,
                                  color: appTheme.gray400.withOpacity(0.46),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                await togglePurchaseStatus(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 55.h,
                                  top: 2.v,
                                  bottom: 3.v,
                                ),
                                child: Text(
                                  "BUY ${widget.book.price} RM",
                                  style: theme.textTheme.titleSmall,
                                ),
                              ),
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
  Widget _buildProjectRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 319.h,
                  child: Text(
                    widget.book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 10.v),
                Text(
                  widget.book.author,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 8.v),
                Text(
                  widget.book.description,
                  style: theme.textTheme.titleSmall,
                )
              ],
            ),
          ),
          CustomImageView(
            imagePath: _isBookFaved
                ? ImageConstant.imgUilBookmark
                : ImageConstant.imgUilBookmarkOnprimary,
            height: 20.adaptSize,
            width: 20.adaptSize,
            onTap: () async {
              await toggleFavoriteStatus(context);
            },
            margin: EdgeInsets.only(
              left: 18.h,
              bottom: 82.v,
            ),
          )
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
              widget.book.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall,
            ),
          ),
          SizedBox(height: 14.v),
          Wrap(
            runSpacing: 8.v,
            spacing: 8.h,
            children: widget.book.genres
                .map((genre) => ChipviewpersonaItemWidget(text: genre))
                .toList(),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFinalSummaryColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.only(left: 16.h),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Padding(
          //         padding: EdgeInsets.only(
          //           top: 7.v,
          //           bottom: 5.v,
          //         ),
          //         child: Text(
          //           "Final Summary",
          //           style: CustomTextStyles.titleMediumPrimary,
          //         ),
          //       ),
          //       CustomIconButton(
          //         height: 32.adaptSize,
          //         width: 32.adaptSize,
          //         padding: EdgeInsets.all(6.h),
          //         child: CustomImageView(
          //           imagePath: ImageConstant.imgUilLock,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          SizedBox(height: 22.v),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.bookDetailsSellerScreen);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.h,
                vertical: 11.v,
              ),
              decoration: AppDecoration.fillBlueGray.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder12,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgEllipse1,
                    height: 54.adaptSize,
                    width: 54.adaptSize,
                    radius: BorderRadius.circular(
                      27.h,
                    ),
                    margin: EdgeInsets.only(bottom: 19.v),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 11.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.book.author,
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 4.v),
                        Text(
                          widget.book.title,
                          style:
                              CustomTextStyles.labelLargeAbhayaLibreExtraBold,
                        ),
                        SizedBox(height: 6.v),
                        SizedBox(
                          width: 216.h,
                          child: Text(
                            "Managers who want to create positive work enviroments",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                CustomTextStyles.labelLargeAbhayaLibreExtraBold,
                          ),
                        )
                      ],
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

  Future<List<DocumentSnapshot>> fetchSimilarBooks(String author,
      String publication, List<String> genres, String currentBookId) async {
    // Query for books by the same author
    final authorQuerySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('author', isEqualTo: author)
        .get();

    // Query for books by the same publication
    final publicationQuerySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('publication', isEqualTo: publication)
        .get();

    // Query for books in the same genres
    final genresQuerySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('genres', arrayContainsAny: genres)
        .get();

    // Combine the results
    final combinedResults = [
      ...authorQuerySnapshot.docs,
      ...publicationQuerySnapshot.docs,
      ...genresQuerySnapshot.docs,
    ];

    // Use a set to avoid duplicates
    final uniqueResults = {
      for (var doc in combinedResults) doc.id: doc,
    };

    // Remove the current book from the results
    uniqueResults.remove(currentBookId);

    return uniqueResults.values.toList();
  }

  /// Section Widget
  Widget _buildSimilarBooksColumn(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Similar Books",
                style: theme.textTheme.titleLarge,
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.v),
                child: Text(
                  "Show all",
                  style:
                      CustomTextStyles.labelLargeAbhayaLibreExtraBoldGreen100,
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgArrowRight,
                height: 16.adaptSize,
                width: 16.adaptSize,
                margin: EdgeInsets.only(
                  left: 4.h,
                  top: 5.v,
                  bottom: 2.v,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 17.v),
        SizedBox(
          height: 270.v,
          child: FutureBuilder<List<DocumentSnapshot>>(
            future: fetchSimilarBooks(widget.book.author, widget.book.publisher,
                widget.book.genres, widget.book.documentId),
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => BookDetailsScreenV(
                                  book: book,
                                )));
                      },
                      child: Userprofile3ItemWidget(book: book),
                    );
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }
}
