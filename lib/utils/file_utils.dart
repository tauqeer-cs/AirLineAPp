
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileUtils {

  static Future<void> downloadFile(String url, String filename) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var httpClient = HttpClient();
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);

      if (Platform.isIOS) {
        var dir = await getApplicationDocumentsDirectory();
        File file = File('${dir?.path}/$filename');
        await file.writeAsBytes(bytes);


        return;
      }

      var dir = await getExternalStorageDirectory();
      File file = File('${dir?.path}/$filename');
      await file.writeAsBytes(bytes);
    } else {
      throw 'Permission denied';
    }
  }

  static Future<void> downloadFileWithBytes(String bytes, String filename) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var httpClient = HttpClient();

      if (Platform.isIOS) {
        var dir = await getApplicationDocumentsDirectory();
        File file = File('${dir?.path}/$filename');
       // await file.writeAsBytes(bytes);

        /*
                final params = SaveFileDialogParams(sourceFilePath: file.path);
        final filePath = await FlutterFileDialog.saveFile(params: params);

        * */
        return;
      }

      var dir = await getExternalStorageDirectory();
      File file = File('${dir?.path}/$filename');
    //  await file.writeAsBytes(bytes);
    } else {
      throw 'Permission denied';
    }
  }




}