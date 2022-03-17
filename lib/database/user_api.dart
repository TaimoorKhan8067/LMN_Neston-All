import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lmn_neston/models/app_user.dart';
import '../models/users.dart';
import '../widgets/custom_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserAPI {
  static const String _collection = 'users';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  // functions
  Future<DocumentSnapshot<Map<String, dynamic>>> getInfo(
      {required String uid}) async {
    return _instance.collection(_collection).doc(uid).get();
  }

  Future<bool> addUser(AppUserModel appUser) async {
    String? _token = await FirebaseMessaging.instance.getToken();
    appUser.NotificationToken = _token!;
    await _instance
        .collection(_collection)
        .doc(appUser.id)
        .set(appUser.toMap())
        .catchError((Object e) {
      CustomToast.successToast(message: e.toString());
      // ignore: invalid_return_type_for_catch_error
      return false;
    });
    return true;
  }

  // Future<AppUserModel> getUidFromEmail({required String email}) async {
  //   return await AppUserModel.fromDocument(_instance
  //       .collection(_collection)
  //       .where('email', isEqualTo: email)
  //       .get());
  // }

  Future<QuerySnapshot<Map<String, dynamic>>> getUidFromEmail(
      {required String email}) async {
    return await _instance
        .collection(_collection)
        .where('email', isEqualTo: email)
        .get();
  }

  // Future<String> uploadImage(File? file, String uid) async {
  //   final Reference ref =
  //       FirebaseStorage.instance.ref().child('users').child(uid);
  //   await ref.putFile(file!);
  //   String url = await ref.getDownloadURL();
  //   return url;
  // }
}
