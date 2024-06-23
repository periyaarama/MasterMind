import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:master_mind/screens/crud_owner/models/book.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PDFViewerPage extends StatelessWidget {
  final Book book;
  final int currentPage;

  const PDFViewerPage({super.key, required this.book, this.currentPage = 1});

  Future<void> _downloadPDF(BuildContext context) async {
    String pdfUrl = book.pdfUrl!;
    final Uri url = Uri.parse(pdfUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $pdfUrl')),
      );
      print('Could not launch $pdfUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          onPressed: () async {
            final _pdfViewWidgetState =
                context.findAncestorStateOfType<_PDFViewWidgetState>();
            if (_pdfViewWidgetState != null) {
              await _pdfViewWidgetState._saveReadingProgress();
            }
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.download,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            onPressed: () => _downloadPDF(context),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: PDFViewWidget(
          book: book,
          currentPage: currentPage,
        ),
      ),
    );
  }
}

class PDFViewWidget extends StatefulWidget {
  final Book book;
  final int currentPage;

  PDFViewWidget({super.key, required this.book, this.currentPage = 1});

  @override
  _PDFViewWidgetState createState() => _PDFViewWidgetState();
}

class _PDFViewWidgetState extends State<PDFViewWidget> {
  bool _isLoading = true;
  String? _localFilePath;
  String? _webPdfUrl;
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // _loadCurrentPage();
    if (kIsWeb) {
      _loadPDFForWeb();
    } else {
      _loadPDFForMobile();
    }
  }

  // Future<void> _loadCurrentPage() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     final doc = await _firestore
  //         .collection('book_progress')
  //         .doc('${user.uid}-${widget.book.documentId}')
  //         .get();
  //     if (doc.exists) {
  //       setState(() {
  //         widget.currentPage = doc['currentPage'] ?? 1;
  //       });
  //     }
  //   }
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _loadPDFForMobile() async {
    try {
      final response = await http.get(Uri.parse(widget.book.pdfUrl!));
      final documentDirectory = await getApplicationDocumentsDirectory();
      final filePath = '${documentDirectory.path}/temp.pdf';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      if (mounted) {
        setState(() {
          _localFilePath = filePath;
          _isLoading = false;
        });
        _pdfViewerController.jumpToPage(widget.currentPage);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load PDF: $e')),
        );
        print('Failed to load PDF: $e');
      }
    }
  }

  Future<void> _loadPDFForWeb() async {
    try {
      if (mounted) {
        setState(() {
          _webPdfUrl = widget.book.pdfUrl;
          _isLoading = false;
        });
        _pdfViewerController.jumpToPage(widget.currentPage);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load PDF: $e')),
        );
        print('Failed to load PDF: $e');
      }
    }
  }

  Future<bool> _saveReadingProgress() async {
    try {
      final int currentPage = _pdfViewerController.pageNumber;
      final int totalPages = _pdfViewerController.pageCount;
      final Timestamp lastUpdate = Timestamp.now();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _firestore
            .collection('book_progress')
            .doc('${user.uid}-${widget.book.documentId}')
            .set({
          'bookId': widget.book.documentId,
          'userId': user.uid,
          'numberOfPages': totalPages,
          'currentPage': currentPage,
          'lastUpdate': lastUpdate,
        });
      }
    } catch (e) {
      print('Failed to save reading progress: $e');
    }
    return true;
  }

  void _onPopInvoked(bool value) async {
    await _saveReadingProgress();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: _onPopInvoked,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : kIsWeb
              ? _webPdfUrl != null
                  ? SfPdfViewer.network(
                      _webPdfUrl!,
                      controller: _pdfViewerController,
                    )
                  : const Center(
                      child: Text(
                        'Failed to load PDF',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
              : _localFilePath != null
                  ? SfPdfViewer.file(
                      File(_localFilePath!),
                      controller: _pdfViewerController,
                    )
                  : const Center(
                      child: Text(
                        'Failed to load PDF',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
    );
  }
}
