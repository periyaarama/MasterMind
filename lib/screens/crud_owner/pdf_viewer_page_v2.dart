import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/pdf.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerPage extends StatelessWidget {
  final String pdfUrl;

  const PDFViewerPage({super.key, required this.pdfUrl});

  Future<void> _downloadPDF(BuildContext context) async {
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
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _downloadPDF(context),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child:
            kIsWeb ? PDFWebView(pdfUrl: pdfUrl) : PDFMobileView(pdfUrl: pdfUrl),
      ),
    );
  }
}

class PDFMobileView extends StatefulWidget {
  final String pdfUrl;

  PDFMobileView({required this.pdfUrl});

  @override
  _PDFMobileViewState createState() => _PDFMobileViewState();
}

class _PDFMobileViewState extends State<PDFMobileView> {
  bool _isLoading = true;
  String? _localFilePath;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      final documentDirectory = await getApplicationDocumentsDirectory();
      final filePath = '${documentDirectory.path}/temp.pdf';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      setState(() {
        _localFilePath = filePath;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load PDF: $e')),
      );
      print('Failed to load PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _localFilePath != null
            ? PDFView(
                filePath: _localFilePath,
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: false,
                pageFling: true,
                onRender: (pages) {
                  setState(() {});
                },
                onError: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error loading PDF: $error')),
                  );
                  print('Error on page : $error');
                },
                onPageError: (page, error) {
                  print('Error on page $page: $error');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error on page $page: $error')),
                  );
                },
              )
            : const Center(
                child: Text('Failed to load PDF'),
              );
  }
}

class PDFWebView extends StatelessWidget {
  final String pdfUrl;

  const PDFWebView({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) => _generatePdf(pdfUrl),
    );
  }

  Future<Uint8List> _generatePdf(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }
}
