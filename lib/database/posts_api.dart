import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lmn_neston/models/CreatePost.dart';
import '../widgets/custom_toast.dart';

class PostApi {
  static const String _collection = 'posts';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  // functions
  Future<DocumentSnapshot<Map<String, dynamic>>> getInfo(
      {required String uid}) async {
    return _instance.collection(_collection).doc(uid).get();
  }

  Future<bool> addPosts(CreatePost userPost) async {
    await _instance
        .collection(_collection)
        .doc(userPost.text)
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
        FirebaseStorage.instance.ref().child('posts').child(uid);
    await ref.putFile(file!);
    String url = await ref.getDownloadURL();
    return url;
  }
}
