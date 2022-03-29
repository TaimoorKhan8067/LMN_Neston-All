import 'dart:convert';

class CreateDoc {
  // final Map? sectionsAppointed;
  CreateDoc({
    this.id,
    // this.text,
    // this.phoneNo,
    // this.password,
    // this.position,
    // this.branch,
    // this.email,
    // this.address,
    this.imageUrl,
    // this.NotificationToken
  });

  final String? id;
  // final String? text;
  final String? imageUrl;
  // final String? phoneNo;
  // final String? password;
  // final String? position;
  // final String? branch;
  // final String? address;
  // final String? email;
  // String? NotificationToken;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // 'text': text,
      // 'phoneNo': phoneNo,
      // 'password': password,
      // 'position': position,
      // 'branch': branch,
      // 'email': email,
      // 'address': address,
      'imageUrl': imageUrl,
      // 'NotificationToken': NotificationToken,
    };
  }

  // ignore: sort_constructors_first
  factory CreateDoc.fromMap(Map<String, dynamic> map) {
    return CreateDoc(
      id: map['id'],
      // text: map['text'],
      // phoneNo: map['phoneNo'],
      // password: map['password'],
      // position: map['position'],
      imageUrl: map['imageUrl'],
      // branch: map['branch'],
      // email: map['email'],
      // address: map['address'],
      // NotificationToken: map['NotificationToken']
    );
  }

  // ignore: sort_constructors_first
  factory CreateDoc.fromDocument(doc) {
    return CreateDoc(
      id: doc.data()['id'],
      // password: doc.data()['password'],
      // text: doc.data()['text'],
      // position: doc.data()['position'],
      // email: doc.data()['email'],
      imageUrl: doc.data()['imageUrl'],
      // branch: doc.data()['branch'],
      // phoneNo: doc.data()['phoneNo'],
      // address: doc.data()['address'],
      // NotificationToken: doc.data()['NotificationToken'],
    );
  }

  factory CreateDoc.fromQuery(doc) {
    return CreateDoc(
      id: doc('id'),
      // password: doc('password'),
      // text: doc.data()['text'],
      // position: doc.data()['position'],
      // email: doc('email'),
      imageUrl: doc.data()['imageUrl'],
      // branch: doc.data()['branch'],
      // phoneNo: doc.data()['phoneNo'],
      // address: doc.data()['address'],
      // NotificationToken: doc('NotificationToken'),
    );
  }
  //String toJson() => json.encode(toMap());

  factory CreateDoc.fromJson(String source) =>
      CreateDoc.fromMap(json.decode(source));
}
