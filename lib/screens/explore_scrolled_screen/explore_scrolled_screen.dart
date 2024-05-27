import 'package:flutter/material.dart';
import 'package:master_mind/screens/book_details_screen/book_details_screen_v.dart';
import 'package:master_mind/screens/book_details_screen/widgets/chipviewpersona_item_widget.dart';
import 'package:master_mind/screens/book_details_screen/widgets/userprofile3_item_widget.dart';
import 'package:master_mind/screens/crud_owner/models/book.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class ExploreScrolledScreen extends StatefulWidget {
  const ExploreScrolledScreen({super.key});

  @override
  State<ExploreScrolledScreen> createState() => _ExploreScrolledScreenState();
}

class _ExploreScrolledScreenState extends State<ExploreScrolledScreen> {
  TextEditingController searchController = TextEditingController();
  String _searchQuery = '';

  Future<List<DocumentSnapshot>> searchBooks(String query) async {
    final firestore = FirebaseFirestore.instance;

    // Perform queries for each searchable field
    final authorQuerySnapshot = await firestore
        .collection('books')
        .where('author', isGreaterThanOrEqualTo: query)
        .where('author', isLessThan: '${query}z')
        .get();

    final titleQuerySnapshot = await firestore
        .collection('books')
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThan: '${query}z')
        .get();

    final publisherQuerySnapshot = await firestore
        .collection('books')
        .where('publisher', isGreaterThanOrEqualTo: query)
        .where('publisher', isLessThan: '${query}z')
        .get();

    final genreQuerySnapshot = await firestore
        .collection('books')
        .where('genre', arrayContains: query)
        .get();

    // Combine the results
    final combinedResults = [
      ...authorQuerySnapshot.docs,
      ...titleQuerySnapshot.docs,
      ...publisherQuerySnapshot.docs,
      ...genreQuerySnapshot.docs,
    ];

    // Use a set to avoid duplicates
    final uniqueResults = {
      for (var doc in combinedResults) doc.id: doc,
    };

    // Search through description field for partial matches
    final allBooksSnapshot = await firestore.collection('books').get();
    for (var book in allBooksSnapshot.docs) {
      final description = book['description'] as String;
      if (description.toLowerCase().contains(query.toLowerCase())) {
        uniqueResults[book.id] = book;
      }
    }

    return uniqueResults.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 15.h,
                  right: 16.h,
                  top: 12.v,
                ),
                child: CustomSearchView(
                  controller: searchController,
                  fillColor: Colors.white,
                  hintText: "Title, author or keyword",
                  onChanged: (p0) {
                    setState(() {
                      _searchQuery = p0;
                    });
                  },
                ),
              ),
              SizedBox(height: 41.v),
              _buildColumnTopics(context),
              SizedBox(height: 38.v),
              _buildSearch(context),
            ],
          ),
        ),
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
              text: "Explore",
            ),
            SizedBox(height: 2.v),
            SizedBox(
              width: 79.h,
              child: Divider(
                color: appTheme.green100,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnTopics(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Topics",
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 15.v),
          Wrap(
            runSpacing: 8.v,
            spacing: 8.h,
            children: ['Mystery', 'Fiction', 'Non-Fiction', 'Sci-Fi', 'Romance']
                .map((genre) => InkWell(
                      child: ChipviewpersonaItemWidget(text: genre),
                      onTap: () {
                        setState(() {
                          searchController.text = genre;
                        });
                      },
                    ))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return _searchQuery.isEmpty
        ? const Center(
            child: Text(
            '',
            style: TextStyle(color: Colors.white),
          ))
        : Expanded(
            child: FutureBuilder<List<DocumentSnapshot>>(
              future: searchBooks(_searchQuery),
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
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (context, index) => const Divider(),
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
          );
  }
}
