import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:dio/dio.dart';
import 'app_navigator.dart';

class AppHelper {
  /// CLOSE KEYBOARD
  static Future closeKeyboard() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// PICK FILE FROM DEVICE
  static Future<List<PlatformFile>> pickFiles({
    bool allowMultiple = true,
    List<String>? allowedExtensions,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      allowedExtensions: allowedExtensions,
      type: allowedExtensions != null ? FileType.custom : FileType.any,
    );
    return result?.files ?? [];
  }

  /// HANDLE FILE BEFORE SEND TO APIS
  static Future<MultipartFile> prepareFileForUpload(String path) async {
    String? mimeType = lookupMimeType(path);
    MediaType? mediaType;
    if (mimeType != null) {
      List<String> types = mimeType.split('/');
      if (types.length == 2) mediaType = MediaType(types[0], types[1]);
    }
    var file = File(path);
    return MultipartFile.fromStream(
      () => file.openRead(),
      await file.length(),
      filename: file.path.split('/').last,
      contentType: mediaType ?? MediaType('application', 'octet-stream'),
    );
  }



  static Future<DateTime?> pickDate({
    DateTime? min,
    DateTime? initial,
    DateTime? max,
  }) async {
    final ctx = AppNavigator.key.currentContext;
    if (ctx != null) {
      return await showDatePicker(
        context: ctx,
        firstDate: min ?? DateTime.now(),
        initialDate: initial ?? min ?? DateTime.now(),
        lastDate: max ?? DateTime.parse("2222-12-31"),
      );
    }
    return null;
  }

}
