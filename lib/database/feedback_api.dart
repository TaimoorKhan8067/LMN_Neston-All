import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lmn_neston/models/FeedBackModel.dart';
import '../widgets/custom_toast.dart';

class FeedBackAPI {
  static const String _collection = 'feedback';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  // functions
  Future<DocumentSnapshot<Map<String, dynamic>>> getInfo(
      {required String uid}) async {
    return _instance.collection(_collection).doc(uid).get();
  }

  Future<bool> addFeedback(FeedBackModel appUser) async {
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

  // Future<FeedBackModel> getUidFromEmail({required String email}) async {
  //   return await FeedBackModel.fromDocument(_instance
  //       .collection(_collection)
  //       .where('email', isEqualTo: email)
  //       .get());
  // }

  // Future<QuerySnapshot<Map<String, dynamic>>> getUidFromEmail(
  //     {required String email}) async {
  //   return await _instance
  //       .collection(_collection)
  //       .where('email', isEqualTo: email)
  //       .get();
  // }

  // Future<String> uploadImage(File? file, String uid) async {
  //   final Reference ref =
  //       FirebaseStorage.instance.ref().child('users').child(uid);
  //   await ref.putFile(file!);
  //   String url = await ref.getDownloadURL();
  //   return url;
  // }
}
