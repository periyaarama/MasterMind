import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:master_mind/theme/custom_text_style.dart';
import 'package:master_mind/widgets/custom_elevated_button.dart';
import 'package:master_mind/widgets/custom_text_form_field.dart';
import 'package:master_mind/theme/custom_button_style.dart';
import 'dart:io'; // Import dart:io

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _numberOfPagesController =
      TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  List<String> selectedGenres = [];
  String? _bookCoverUrl;
  String? _bookPdfUrl;

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

  Future<void> _uploadFile(String fileType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType == 'cover' ? FileType.image : FileType.custom,
      allowedExtensions: fileType == 'pdf' ? ['pdf'] : null,
    );

    if (result != null && result.files.single.path != null) {
      String filePath = result.files.single.path!;
      String fileName = result.files.single.name;

      try {
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('User not logged in.'),
          ));
          return;
        }

        String destination = fileType == 'cover'
            ? 'book_covers/$fileName'
            : 'book_pdfs/$fileName';
        Reference ref = FirebaseStorage.instance.ref(destination);
        UploadTask uploadTask = ref.putFile(File(filePath));

        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        setState(() {
          if (fileType == 'cover') {
            _bookCoverUrl = downloadUrl;
          } else if (fileType == 'pdf') {
            _bookPdfUrl = downloadUrl;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$fileType uploaded successfully!'),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to upload $fileType: $e'),
        ));
      }
    }
  }

  Future<void> _uploadBook() async {
    if (_formKey.currentState!.validate()) {
      final currentUser = FirebaseAuth.instance.currentUser;
      final ownerEmail = currentUser?.email;

      if (ownerEmail != null) {
        Map<String, dynamic> bookData = {
          'title': _titleController.text,
          'author': _authorController.text,
          'isbn': _isbnController.text,
          'publisher': _publisherController.text,
          'genres': selectedGenres,
          'description': _descriptionController.text,
          'numberOfPages': int.tryParse(_numberOfPagesController.text) ?? 0,
          'price': double.tryParse(_priceController.text) ?? 0.0,
          'ownerEmail': ownerEmail,
          'bookCoverUrl': _bookCoverUrl,
          'bookPdfUrl': _bookPdfUrl,
        };

        try {
          DocumentReference documentReference =
              FirebaseFirestore.instance.collection('books').doc();
          await documentReference.set(bookData);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Book uploaded successfully!'),
          ));
          _formKey.currentState?.reset();
          setState(() {
            selectedGenres.clear();
            _bookCoverUrl = null;
            _bookPdfUrl = null;
          });
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to upload book: $e'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('User not logged in.'),
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
                      _uploadFile('cover');
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
                      _uploadFile('pdf');
                    },
                  ),
                  const SizedBox(height: 20.0),
                  CustomElevatedButton(
                    height: 48.0,
                    text: "Upload",
                    margin: const EdgeInsets.symmetric(horizontal: 17.0),
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    buttonTextStyle:
                        CustomTextStyles.titleSmallPrimaryContainer,
                    onPressed: () async {
                      await _uploadBook();
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
      title: const Text('Upload Book'),
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
          Text("Genres", style: CustomTextStyles.labelLargeAbhayaLibreExtraBold),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: [
              for (var genre in selectedGenres)
                Chip(
                  label: Text(genre),
                  onDeleted: () {
                    setState(() {
                      selectedGenres.remove(genre);
                    });
                  },
                ),
              GestureDetector(
                onTap: () async {
                  // Logic to add new genres
                  // This can be a dialog or another screen to select genres
                },
                child: Chip(
                  label: Text(
                    "Add Genre",
                    style: TextStyle(color: Colors.blue),
                  ),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
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
            maxLines: 5,
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
