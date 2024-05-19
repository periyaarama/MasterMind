import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:master_mind/theme/custom_text_style.dart';
import 'package:master_mind/widgets/custom_elevated_button.dart';
import 'package:master_mind/widgets/custom_text_form_field.dart';
import 'package:master_mind/theme/custom_button_style.dart';
import 'package:master_mind/screens/crud_owner/models/book.dart';

class UpdatePage extends StatefulWidget {
  final Book book;

  const UpdatePage({super.key, required this.book});

  @override
  // ignore: library_private_types_in_public_api
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _isbnController;
  late TextEditingController _publisherController;
  late TextEditingController _descriptionController;
  late TextEditingController _numberOfPagesController;
  late TextEditingController _priceController;
  List<String> selectedGenres = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.author);
    _isbnController = TextEditingController(text: widget.book.isbn);
    _publisherController = TextEditingController(text: widget.book.publisher);
    _descriptionController =
        TextEditingController(text: widget.book.description);
    _numberOfPagesController =
        TextEditingController(text: widget.book.numberOfPages.toString());
    _priceController =
        TextEditingController(text: widget.book.price.toString());
    selectedGenres = List.from(widget.book.genres);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _isbnController.dispose();
    _publisherController.dispose();
    _descriptionController.dispose();
    _numberOfPagesController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _updateBook() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> bookData = {
        'title': _titleController.text,
        'author': _authorController.text,
        'isbn': _isbnController.text,
        'publisher': _publisherController.text,
        'genres': selectedGenres,
        'description': _descriptionController.text,
        'numberOfPages': int.tryParse(_numberOfPagesController.text) ?? 0,
        'price': double.tryParse(_priceController.text) ?? 0.0,
      };

      try {
        await FirebaseFirestore.instance
            .collection('books')
            .doc(widget.book.documentId)
            .update(bookData);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Book updated successfully!'),
        ));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update book: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildColumnTitle(context),
                  const SizedBox(height: 23.0),
                  _buildColumnAuthor(context),
                  const SizedBox(height: 23.0),
                  _buildColumnISBN(context),
                  const SizedBox(height: 22.0),
                  _buildColumnPublisher(context),
                  const SizedBox(height: 22.0),
                  _buildColumnGenres(context),
                  const SizedBox(height: 22.0),
                  _buildColumnDescription(context),
                  const SizedBox(height: 22.0),
                  _buildColumnNumberOfPages(context),
                  const SizedBox(height: 22.0),
                  _buildColumnPrice(context),
                  const SizedBox(height: 32.0),
                  CustomElevatedButton(
                    height: 48.0,
                    text: "Add Book Cover",
                    margin: const EdgeInsets.symmetric(horizontal: 17.0),
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    buttonTextStyle:
                        CustomTextStyles.titleSmallPrimaryContainer,
                    onPressed: () {
                      // Implement logic to select and upload book cover image
                    },
                  ),
                  const SizedBox(height: 20.0),
                  CustomElevatedButton(
                    height: 48.0,
                    text: "Add Book (PDF)",
                    margin: const EdgeInsets.symmetric(horizontal: 17.0),
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    buttonTextStyle:
                        CustomTextStyles.titleSmallPrimaryContainer,
                    onPressed: () {
                      // Implement logic to select and upload book (PDF)
                    },
                  ),
                  const SizedBox(height: 24.0),
                  CustomElevatedButton(
                    height: 48.0,
                    text: "Update",
                    margin: const EdgeInsets.symmetric(horizontal: 17.0),
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    buttonTextStyle:
                        CustomTextStyles.titleSmallPrimaryContainer,
                    onPressed: () async {
                      await _updateBook();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Update Book'),
      backgroundColor: Colors.blueAccent,
    );
  }

  Widget _buildColumnTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Title", style: CustomTextStyles.labelLargeAbhayaLibreExtraBold),
          const SizedBox(height: 8.0),
          CustomTextFormField(
            controller: _titleController,
            hintText: _titleController.text,
          ),
        ],
      ),
    );
  }

  Widget _buildColumnAuthor(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Author",
              style: CustomTextStyles.labelLargeAbhayaLibreExtraBold),
          const SizedBox(height: 8.0),
          CustomTextFormField(
            controller: _authorController,
            hintText: _authorController.text,
          ),
        ],
      ),
    );
  }

  Widget _buildColumnISBN(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ISBN", style: CustomTextStyles.labelLargeAbhayaLibreExtraBold),
          const SizedBox(height: 8.0),
          CustomTextFormField(
            controller: _isbnController,
            hintText: _isbnController.text,
          ),
        ],
      ),
    );
  }

  Widget _buildColumnPublisher(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Publisher",
              style: CustomTextStyles.labelLargeAbhayaLibreExtraBold),
          const SizedBox(height: 8.0),
          CustomTextFormField(
            controller: _publisherController,
            hintText: _publisherController.text,
          ),
        ],
      ),
    );
  }

  Widget _buildColumnGenres(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Genre/Category",
              style: CustomTextStyles.labelLargeAbhayaLibreExtraBold),
          const SizedBox(height: 8.0),
          _buildGenreCheckbox('Fiction'),
          _buildGenreCheckbox('Non-Fiction'),
          _buildGenreCheckbox('Mystery'),
          _buildGenreCheckbox('Romance'),
          _buildGenreCheckbox('Sci-Fi'),
        ],
      ),
    );
  }

  Widget _buildGenreCheckbox(String genre) {
    return CheckboxListTile(
      title: Text(genre,
          style: const TextStyle(color: Color.fromARGB(255, 162, 239, 138))),
      value: selectedGenres.contains(genre),
      activeColor: const Color.fromARGB(255, 162, 239, 138),
      checkColor: const Color.fromARGB(255, 162, 239, 138),
      onChanged: (bool? value) {
        setState(() {
          if (value != null && value) {
            selectedGenres.add(genre);
          } else {
            selectedGenres.remove(genre);
          }
        });
      },
    );
  }

  Widget _buildColumnDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Description",
              style: CustomTextStyles.labelLargeAbhayaLibreExtraBold),
          const SizedBox(height: 8.0),
          CustomTextFormField(
            controller: _descriptionController,
            hintText: _descriptionController.text,
          ),
        ],
      ),
    );
  }

  Widget _buildColumnNumberOfPages(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Number of Pages",
              style: CustomTextStyles.labelLargeAbhayaLibreExtraBold),
          const SizedBox(height: 8.0),
          CustomTextFormField(
            controller: _numberOfPagesController,
            hintText: _numberOfPagesController.text,
          ),
        ],
      ),
    );
  }

  Widget _buildColumnPrice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Price", style: CustomTextStyles.labelLargeAbhayaLibreExtraBold),
          const SizedBox(height: 8.0),
          CustomTextFormField(
            controller: _priceController,
            hintText: _priceController.text,
          ),
        ],
      ),
    );
  }
}
