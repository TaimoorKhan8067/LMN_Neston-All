import 'dart:convert';

class AppUserModel {
  // final Map? sectionsAppointed;
  AppUserModel(
      {this.id,
      this.name,
      this.phoneNo,
      this.password,
      this.position,
      this.branch,
      this.email,
      this.address,
      this.imageUrl,
      this.NotificationToken,
      this.points});

  final String? id;
  final String? name;
  final String? imageUrl;
  final String? phoneNo;
  final String? password;
  final String? position;
  final String? branch;
  final String? address;
  final String? email;
  final String? points;
  String? NotificationToken;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNo': phoneNo,
      'password': password,
      'position': position,
      'branch': branch,
      'email': email,
      'address': address,
      'imageUrl': imageUrl,
      'points': points,
      'NotificationToken': NotificationToken,
    };
  }

  // ignore: sort_constructors_first
  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
        id: map['id'],
        name: map['userName'],
        phoneNo: map['phoneNo'],
        password: map['password'],
        position: map['position'],
        imageUrl: map['imageUrl'],
        branch: map['branch'],
        email: map['email'],
        address: map['address'],
        points: map['points'],
        NotificationToken: map['NotificationToken']);
  }

  // ignore: sort_constructors_first
  factory AppUserModel.fromDocument(doc) {
    return AppUserModel(
      id: doc.data()['id'],
      password: doc.data()['password'],
      name: doc.data()['name'],
      position: doc.data()['position'],
      email: doc.data()['email'],
      imageUrl: doc.data()['imageUrl'],
      branch: doc.data()['branch'],
      phoneNo: doc.data()['phoneNo'],
      address: doc.data()['address'],
      points: doc.data()['points'],
      NotificationToken: doc.data()['NotificationToken'],
    );
  }

  factory AppUserModel.fromQuery(doc) {
    return AppUserModel(
      id: doc('id'),
      password: doc('password'),
      name: doc.data()['name'],
      position: doc.data()['position'],
      email: doc('email'),
      imageUrl: doc.data()['imageUrl'],
      branch: doc.data()['branch'],
      phoneNo: doc.data()['phoneNo'],
      address: doc.data()['address'],
      points: doc.data()['points'],
      NotificationToken: doc('NotificationToken'),
    );
  }
  //String toJson() => json.encode(toMap());

  factory AppUserModel.fromJson(String source) =>
      AppUserModel.fromMap(json.decode(source));
}
