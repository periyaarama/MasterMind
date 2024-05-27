import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:master_mind/theme/custom_button_style.dart';
import 'package:master_mind/theme/custom_text_style.dart';
import 'package:master_mind/widgets/custom_elevated_button.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'dart:io';

import 'package:master_mind/widgets/custom_text_form_field.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

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
  String? _imgUrl;
  String? _pdfUrl;

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
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: fileType == 'cover' ? FileType.image : FileType.custom,
        allowedExtensions: fileType == 'pdf' ? ['pdf'] : null,
      );

      if (result != null) {
        Uint8List? fileBytes;
        String fileName = result.files.single.name;

        if (kIsWeb) {
          // Running on web, use bytes
          fileBytes = result.files.single.bytes;
        } else {
          // Running on other platforms, use path
          String? filePath = result.files.single.path;
          if (filePath != null) {
            fileBytes = await File(filePath).readAsBytes();
          }
        }

        if (fileBytes != null) {
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
          UploadTask uploadTask = ref.putData(fileBytes);

          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
          String downloadUrl = await taskSnapshot.ref.getDownloadURL();
          print(downloadUrl);

          if (fileType == 'cover') {
            setState(() {
              _imgUrl = downloadUrl;
            });
          } else if (fileType == 'pdf') {
            setState(() {
              _pdfUrl = downloadUrl;
            });
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('$fileType uploaded successfully!'),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Failed to read file.'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No file selected.'),
        ));
      }
    } catch (e) {
      print('Error uploading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to upload $fileType: $e'),
      ));
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
          'imgUrl': _imgUrl,
          'pdfUrl': _pdfUrl,
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
            _imgUrl = null;
            _pdfUrl = null;
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
        appBar: AppBar(
          title: const Text('Upload Book'),
          backgroundColor: Colors.blueAccent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildColumnTitle(),
                  const SizedBox(height: 23.0),
                  _buildColumnAuthor(),
                  const SizedBox(height: 23.0),
                  _buildColumnISBN(),
                  const SizedBox(height: 22.0),
                  _buildColumnPublisher(),
                  const SizedBox(height: 22.0),
                  _buildColumnGenres(),
                  const SizedBox(height: 22.0),
                  _buildColumnDescription(),
                  const SizedBox(height: 22.0),
                  _buildColumnNumberOfPages(),
                  const SizedBox(height: 22.0),
                  _buildColumnPrice(),
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

  Widget _buildColumnTitle() {
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

  Widget _buildColumnAuthor() {
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

  Widget _buildColumnISBN() {
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

  Widget _buildColumnPublisher() {
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

  Widget _buildColumnGenres() {
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

  Widget _buildColumnDescription() {
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

  Widget _buildColumnNumberOfPages() {
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

  Widget _buildColumnPrice() {
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
