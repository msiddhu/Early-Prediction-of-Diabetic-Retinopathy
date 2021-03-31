import 'package:flutter/cupertino.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class PdfPreviewScreen extends StatelessWidget {
  String path;
  PdfPreviewScreen(String fullpath){
    path=fullpath;
  }
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      path: path,
    );
  }
}
