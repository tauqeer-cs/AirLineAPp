
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class FileUtils {

  static Future<void> saveFileToDownloadsFolder(File file) async {
    final externalDir = await getExternalStorageDirectory();
    Directory dir = Directory('/storage/emulated/0/Download/MyAir');

    final downloadsDir = Directory('${externalDir?.path}/Download');
    await dir.create(recursive: true);
    final savedFile = await file.copy('${dir.path}/${file.path.split('/').last}');
    print('File saved to: ${savedFile.path}');
  }

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
      saveFileToDownloadsFolder(file);

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