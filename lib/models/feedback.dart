import 'package:cloud_firestore/cloud_firestore.dart';

class UserFeedback {
  UserFeedback({
    this.id,
    // this.name,
    // this.imageUrl,
    // this.phoneNo,
    this.feedback,
    // this.createdAt,
    // this.joinedAt,
    // this.isAdmin = false,
  });
  final String? id;
  // final String? name;
  // final String? imageUrl;
  // final String? phoneNo;
  final String? feedback;
  // final Timestamp? createdAt;
  // final String? joinedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id!.trim(),
      // 'name': name!.trim(),
      // 'imageUrl': imageUrl!.trim(),
      // 'phoneNo': phoneNo!.trim(),
      'feedback': feedback!.trim(),
      // 'createdAt': createdAt,
      // 'joinedAt': joinedAt,
      // 'isAdmin': isAdmin,
    };
  }

  // ignore: sort_constructors_first
  factory UserFeedback.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> docs) {
    return UserFeedback(
      id: docs.data()!['id'].toString(),
      // name: docs.data()!['name'].toString(),
      // imageUrl: docs.data()!['imageUrl'].toString(),
      // phoneNo: docs.data()!['phoneNo'].toString(),
      feedback: docs.data()!['feedback'].toString(),
      // joinedAt: docs.data()!['joinedAt'].toString(),
      // isAdmin: bool.fromEnvironment(docs.data()!['isAdmin'].toString()),
    );
  }
}
