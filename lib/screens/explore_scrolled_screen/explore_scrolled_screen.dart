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
  late TextEditingController searchController;
  late String _searchQuery;
  Future<List<DocumentSnapshot>>? _searchFuture;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _searchQuery = '';
  }

  Future<List<DocumentSnapshot>> searchBooks(String query) async {
    final firestore = FirebaseFirestore.instance;

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
        .where('genres', arrayContains: query)
        .get();

    final combinedResults = [
      ...authorQuerySnapshot.docs,
      ...titleQuerySnapshot.docs,
      ...publisherQuerySnapshot.docs,
      ...genreQuerySnapshot.docs,
    ];

    final uniqueResults = {
      for (var doc in combinedResults) doc.id: doc,
    };

    final allBooksSnapshot = await firestore.collection('books').get();
    for (var book in allBooksSnapshot.docs) {
      final description = book.data().containsKey('description')
          ? book['description'] as String
          : '';
      if (description.toLowerCase().contains(query.toLowerCase())) {
        uniqueResults[book.id] = book;
      }
    }

    return uniqueResults.values.toList();
  }

  void _initiateSearch(String query) {
    setState(() {
      _searchQuery = query;
      _searchFuture = searchBooks(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 12.0),
                child: CustomSearchView(
                  controller: searchController,
                  fillColor: Colors.white,
                  hintText: "Title, author or keyword",
                  onChanged: (p0) {
                    _initiateSearch(p0);
                  },
                ),
              ),
              const SizedBox(height: 41.0),
              _buildColumnTopics(context),
              const SizedBox(height: 38.0),
              Expanded(child: _buildSearch(context)),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppbarTitle(
              text: "Explore",
            ),
            const SizedBox(height: 2.0),
            SizedBox(
              width: 79.0,
              child: Divider(
                color: appTheme.green100,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildColumnTopics(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Topics",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 15.0),
          Wrap(
            runSpacing: 8.0,
            spacing: 8.0,
            children: ['Mystery', 'Fiction', 'Non-Fiction', 'Sci-Fi', 'Romance']
                .map((genre) => InkWell(
                      child: ChipviewpersonaItemWidget(text: genre),
                      onTap: () {
                        _initiateSearch(genre);
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
        : FutureBuilder<List<DocumentSnapshot>>(
            future: _searchFuture,
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
          );
  }
}
