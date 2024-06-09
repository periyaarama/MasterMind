import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class SimplePdf extends StatelessWidget {
//   const SimplePdf({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Pdf View'),
//       ),
//       body: SfPdfViewer.network(
//           'https://www.clickdimensions.com/links/TestPDFfile.pdf'),
//     );
//   }
// }

class SimplePdf extends StatefulWidget {
  const SimplePdf({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SimplePdf createState() => _SimplePdf();
}

class _SimplePdf extends State<SimplePdf> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
        key: _pdfViewerKey,
      ),
    );
  }
}
