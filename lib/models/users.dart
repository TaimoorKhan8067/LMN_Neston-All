import 'dart:convert';

class AppUserModel {
  // final Map? sectionsAppointed;
  AppUserModel(
      {this.id,
      // this.name,
      // this.phoneNo,
      this.password,
      // this.createdAt,
      // this.isAdmin,
      this.email,
      // this.joinedAt,
      // this.imageUrl,
      this.NotificationToken});

  final String? id;
  // final String? name;
  // final String? imageUrl;
  // final int? phoneNo;
  final String? password;
  // final Timestamp? createdAt;
  // final String? joinedAt;
  // final bool? isAdmin;
  final String? email;
  String? NotificationToken;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // 'name': name,
      // 'phoneNo': phoneNo,
      'password': password,
      // 'createdAt': createdAt,
      // 'isAdmin': isAdmin,
      'email': email,
      // 'joinedAt': joinedAt,
      // 'imageUrl': imageUrl,
      'NotificationToken': NotificationToken,
    };
  }

  // ignore: sort_constructors_first
  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
        id: map['id'],
        // name: map['userName'],
        // phoneNo: map['phoneNo'],
        password: map['password'],
        // createdAt: map['createdAt'],
        // imageUrl: map['imageUrl'],
        // isAdmin: map['isAdmin'],
        email: map['email'],
        // joinedAt: map['joinedAt'],
        NotificationToken: map['NotificationToken']);
  }

  // ignore: sort_constructors_first
  factory AppUserModel.fromDocument(doc) {
    return AppUserModel(
      id: doc.data()['id'],
      password: doc.data()['password'],
      // name: doc.data()['name'],
      // createdAt: doc.data()['createdAt'],
      email: doc.data()['email'],
      // imageUrl: doc.data()['imageUrl'],
      // isAdmin: doc.data()['isAdmin'],
      // phoneNo: doc.data()['phoneNo'],
      // joinedAt: doc.data()['joinedAt'],
      NotificationToken: doc.data()['NotificationToken'],
    );
  }

  factory AppUserModel.fromQuery(doc) {
    return AppUserModel(
      id: doc('id'),
      password: doc('password'),
      // name: doc.data()['name'],
      // createdAt: doc.data()['createdAt'],
      email: doc('email'),
      // imageUrl: doc.data()['imageUrl'],
      // isAdmin: doc.data()['isAdmin'],
      // phoneNo: doc.data()['phoneNo'],
      // joinedAt: doc.data()['joinedAt'],
      NotificationToken: doc('NotificationToken'),
    );
  }
  //String toJson() => json.encode(toMap());

  factory AppUserModel.fromJson(String source) =>
      AppUserModel.fromMap(json.decode(source));
}
