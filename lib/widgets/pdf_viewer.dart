import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;

import 'package:app/app/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

import 'app_app_bar.dart';

class PdfViewer extends StatefulWidget {
  final String title;
  final String fileName;

  final bool pdfIsLink;

  const PdfViewer(
      {Key? key,
      required this.title,
      required this.fileName,
      this.pdfIsLink = false})
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

  String? remotePDFpath;

  @override
  void initState() {
    super.initState();
    if (!widget.pdfIsLink) {
      getFileFromAssets('pdf/${widget.fileName}.pdf');
    } else {
      //loadPdf();
      createFileOfPdfUrl().then((f) {
        print("f is ${f.path}");
        setState(() {
          remotePDFpath = f.path;
        });
      });
    }
  }

  Future<String> downloadAndSavePdf() async {
    String url = widget.fileName;
    Uri uri = Uri.parse(url);
    String name = uri.pathSegments.last;

    final directory = await getApplicationDocumentsDirectory();
    final file = io.File('${directory.path}/$name');

    if (await file.exists()) {
      return file.path;
    }

    final response = await Dio().getUri(Uri.parse(widget.fileName));
    await file.writeAsBytes(utf8.encode(response.data));
    return file.path;
  }

  String? pdfFlePath;

  void loadPdf() async {
    pdfFlePath = await downloadAndSavePdf();
    setState(() {});
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    try {
      var url = widget.fileName;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        centerTitle: true,
        title: widget.title,
        height: 60.h,
      ),
      body: buildPdfView(),
    );
  }

  Widget buildPdfView() {
    if (widget.pdfIsLink) {
      return remotePDFpath == null
          ? Text("")
          : PDFView(
              filePath: remotePDFpath,
              onRender: (pages) {},
              onError: (error) {
                logger.e('error: ${error.toString()}');

              },
              onPageError: (page, error) {
                logger.e('$page: ${error.toString()}');
              },
            );
    }
    if (pathPDF.isEmpty) {
      return Text("");
    }
    return PDFView(
      filePath: pathPDF,
      onRender: (pages) {},
      onError: (error) {},
      onPageError: (page, error) {
        logger.e('$page: ${error.toString()}');
      },
    );
  }
}
//,
