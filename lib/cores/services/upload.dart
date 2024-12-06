import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadService {
  Future<String> uploadImage(File file) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    final proPicRef = storage.ref('uploads/$id');
    String url;
    await proPicRef.putFile(file).then((p0) async {
      if (p0.state == TaskState.success) {
        url = await proPicRef.getDownloadURL();
        debugPrint("Picture updated successfully");
        return url;
      } else if (p0.state == TaskState.running) {
        debugPrint('Uploading Picture');
      } else {
        debugPrint("Error while uploading Profile Picture");
        return Future.error("Error while uploading picture");
      }
    });
    url = await proPicRef.getDownloadURL();
    debugPrint(url);
    return url;
  }
}
