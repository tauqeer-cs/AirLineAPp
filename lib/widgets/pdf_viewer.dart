import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'app_app_bar.dart';
import 'dart:io' as io;

class PdfViewer extends StatefulWidget {
  final String title;
  final String fileName;

  PdfViewer({Key? key, required this.title, required this.fileName})
      : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  String pathPDF = "";

  Future<io.File> getFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = io.File('${(await getTemporaryDirectory()).path}/$path');
    if (!file.existsSync()) {
      await io.File(file.path).create(recursive: true);
    }

    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    setState(() {
      pathPDF = file.path;
    });

    return file;
  }

  @override
  void initState() {
    super.initState();
    getFileFromAssets('pdfs/${widget.fileName}.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        centerTitle: true,
        title: widget.title,
        height: 80.h,
      ),
      body: pathPDF.isEmpty
          ? Container()
          : PDFView(
              filePath: pathPDF,
              onRender: (pages) {},
              onError: (error) {},
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
            ),
    );
  }
}
//,
