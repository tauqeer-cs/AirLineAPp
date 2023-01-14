import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';

import 'app_app_bar.dart';

class PdfViewer extends StatelessWidget {
  final String title;
  final String fileName;

  const PdfViewer({Key? key, required this.title, required this.fileName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppAppBar(
        centerTitle: true,
        title: title,
        height: 80.h,
      ),
      body: SfPdfViewer.asset(
        'assets/pdfs/$fileName.pdf',
      ),
    );
  }
}
