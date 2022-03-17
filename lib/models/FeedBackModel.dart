import 'dart:convert';

class FeedBackModel {
  // final Map? sectionsAppointed;
  FeedBackModel({
    this.id,
    // this.name,
    // this.phoneNo,
    this.feedback,
    // this.createdAt,
    // this.isAdmin,
    // this.joinedAt,
    // this.imageUrl,
  });

  final String? id;
  // final String? name;
  // final String? imageUrl;
  // final int? phoneNo;
  final String? feedback;
  // final Timestamp? createdAt;
  // final String? joinedAt;
  // final bool? isAdmin;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // 'name': name,
      // 'phoneNo': phoneNo,
      'feedback': feedback,
      // 'createdAt': createdAt,
      // 'isAdmin': isAdmin,
      // 'email': email,
      // 'joinedAt': joinedAt,
      // 'imageUrl': imageUrl,
      // 'NotificationToken': NotificationToken,
    };
  }

  // ignore: sort_constructors_first
  factory FeedBackModel.fromMap(Map<String, dynamic> map) {
    return FeedBackModel(
      id: map['id'],
      // name: map['userName'],
      // phoneNo: map['phoneNo'],
      feedback: map['feedback'],
      // createdAt: map['createdAt'],
      // imageUrl: map['imageUrl'],
      // isAdmin: map['isAdmin'],
      // email: map['email'],
      // joinedAt: map['joinedAt'],
      // NotificationToken: map['NotificationToken']
    );
  }

  // ignore: sort_constructors_first
  factory FeedBackModel.fromDocument(doc) {
    return FeedBackModel(
      id: doc.data()['id'],
      feedback: doc.data()['feedback'],
      // name: doc.data()['name'],
      // createdAt: doc.data()['createdAt'],
      // email: doc.data()['email'],
      // imageUrl: doc.data()['imageUrl'],
      // isAdmin: doc.data()['isAdmin'],
      // phoneNo: doc.data()['phoneNo'],
      // joinedAt: doc.data()['joinedAt'],
      // NotificationToken: doc.data()['NotificationToken'],
    );
  }

  factory FeedBackModel.fromQuery(doc) {
    return FeedBackModel(
      id: doc('id'),
      feedback: doc('feedback'),
      // name: doc.data()['name'],
      // createdAt: doc.data()['createdAt'],
      // email: doc('email'),
      // imageUrl: doc.data()['imageUrl'],
      // isAdmin: doc.data()['isAdmin'],
      // phoneNo: doc.data()['phoneNo'],
      // joinedAt: doc.data()['joinedAt'],
      // NotificationToken: doc('NotificationToken'),
    );
  }
  //String toJson() => json.encode(toMap());

  factory FeedBackModel.fromJson(String source) =>
      FeedBackModel.fromMap(json.decode(source));
}
