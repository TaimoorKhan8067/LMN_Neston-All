import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  AppUser({
    this.id,
    this.name,
    this.imageUrl,
    this.phoneNo,
    this.password,
    this.position,
    this.address,
    this.branch,
    this.email,
    this.androidNotificationToken = '',
  });
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? phoneNo;
  final String? password;
  final String? position;
  final String? branch;
  final String? address;
  final String? email;
  final String? androidNotificationToken;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id!.trim(),
      'name': name!.trim(),
      'imageUrl': imageUrl!.trim(),
      'phoneNo': phoneNo!.trim(),
      'password': password!.trim(),
      'position': position,
      'branch': branch,
      'address': address,
      'email': email!.trim(),
      'androidNotificationToken': androidNotificationToken,
    };
  }

  // ignore: sort_constructors_first
  factory AppUser.fromDocument(DocumentSnapshot<Map<String, dynamic>> docs) {
    return AppUser(
      id: docs.data()!['id'].toString(),
      name: docs.data()!['name'].toString(),
      imageUrl: docs.data()!['imageUrl'].toString(),
      phoneNo: docs.data()!['phoneNo'].toString(),
      password: docs.data()!['password'].toString(),
      position: docs.data()!['position'].toString(),
      branch: docs.data()!['branch'].toString(),
      address: docs.data()!['address'].toString(),
      email: docs.data()!['email'].toString(),
      androidNotificationToken:
          docs.data()!['androidNotificationToken'].toString(),
    );
  }
}
