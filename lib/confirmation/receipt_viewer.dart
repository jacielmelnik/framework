import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class ReceiptViewer extends StatelessWidget {
  const ReceiptViewer({Key? key, required this.file}) : super(key: key);

  final File file;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: MediaQuery.of(context).size.width,
      child: PdfView(path: file.path),
    );
  }
}
