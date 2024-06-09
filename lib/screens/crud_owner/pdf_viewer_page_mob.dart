import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.download,
              color: Colors.white,
            ),
            onPressed: () => _downloadPDF(context),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: PDFViewWidget(pdfUrl: pdfUrl),
      ),
    );
  }
}

class PDFViewWidget extends StatefulWidget {
  final String pdfUrl;

  const PDFViewWidget({super.key, required this.pdfUrl});

  @override
  // ignore: library_private_types_in_public_api
  _PDFViewWidgetState createState() => _PDFViewWidgetState();
}

class _PDFViewWidgetState extends State<PDFViewWidget> {
  bool _isLoading = true;
  String? _localFilePath;
  String? _webPdfUrl;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _loadPDFForWeb();
    } else {
      _loadPDFForMobile();
    }
  }

  Future<void> _loadPDFForMobile() async {
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

  Future<void> _loadPDFForWeb() async {
    try {
      setState(() {
        _webPdfUrl = widget.pdfUrl;
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
        : kIsWeb
            ? _webPdfUrl != null
                ? SfPdfViewer.network(_webPdfUrl!)
                : const Center(
                    child: Text(
                      'Failed to load PDF',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
            : _localFilePath != null
                ? SfPdfViewer.file(File(_localFilePath!))
                : const Center(
                    child: Text(
                      'Failed to load PDF',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
  }
}
