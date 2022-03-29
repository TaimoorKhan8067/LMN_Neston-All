import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lmn_neston/models/CreatePost.dart';

class GetPostsAPI {
  static const String _collection = 'posts';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  // functions
  // Future<CreatePost?>? getProductByPID({required String pid}) async {
  //   final DocumentSnapshot<Map<String, dynamic>>? doc =
  //       await _instance.collection(_collection).doc(pid).get();
  //   if (doc?.data() == null) return null;
  //   return CreatePost.fromDoc(doc!);
  // }

  // Future<List<CreatePost>> getProductsByUID({required String uid}) async {
  //   List<CreatePost> _products = <CreatePost>[];
  //   final QuerySnapshot<Map<String, dynamic>> doc = await _instance
  //       .collection(_collection)
  //       .where('uid', isEqualTo: uid)
  //       .orderBy('timestamp', descending: true)
  //       .get();
  //   for (DocumentSnapshot<Map<String, dynamic>> element in doc.docs) {
  //     _products.add(CreatePost.fromDoc(element));
  //   }
  //   return _products;
  // }

  Future<List<CreatePost>> getProducts() async {
    List<CreatePost> _products = <CreatePost>[];
    final QuerySnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).get();
    for (DocumentSnapshot<Map<String, dynamic>> element in doc.docs) {
      _products.add(CreatePost.fromDocument(element));
    }
    return _products;
  }
}
