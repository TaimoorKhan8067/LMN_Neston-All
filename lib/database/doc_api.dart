import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lmn_neston/models/docUpload.dart';
import '../widgets/custom_toast.dart';

class DocApi {
  static const String _collection = 'document';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  // functions

  Future<bool> addPosts(CreateDoc userPost) async {
    await _instance
        .collection(_collection)
        .doc(userPost.id)
        .set(userPost.toMap())
        .catchError((Object e) {
      CustomToast.successToast(message: e.toString());
      // ignore: invalid_return_type_for_catch_error
      return false;
    });
    return true;
  }

  Future<String> uploadImage(File? file, String uid) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('document').child(uid);
    await ref.putFile(file!);
    String url = await ref.getDownloadURL();
    return url;
  }
}
