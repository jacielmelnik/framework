import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class ReceiptViewer extends StatelessWidget {
  const ReceiptViewer({Key? key, required this.document}) : super(key: key);

  final PDFDocument document;

  @override
  Widget build(BuildContext context) {
    return PDFViewer(document: document);
  }
}
