import 'package:flutter/material.dart';

import '../database/user_local_data.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = UserLocalData.getUserDisplayName;
  String imageUrl = UserLocalData.getUserImageUrl;
  String email = UserLocalData.getUserEmail;
  String phone = UserLocalData.getPhoneNumber;
  String branch = UserLocalData.getBranch;
  String position = UserLocalData.getUUserPosition;
  String address = UserLocalData.getUUserAddress;
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: _height / 12,
                  ),
                  CircleAvatar(
                    radius: _width < _height ? _width / 4 : _height / 4,
                    // backgroundImage: NetworkImage(imageUrl),
                    // ignore: unnecessary_null_comparison
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl)
                        : const AssetImage('assets/dummy.jpg') as ImageProvider,
                  ),
                  SizedBox(
                    height: _height / 25.0,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: _width / 15,
                    ),
                  ),
                  const Divider(color: Colors.black, indent: 20, endIndent: 20),
                  Padding(
                    padding: EdgeInsets.only(
                        top: _height / 30, left: _width / 8, right: _width / 8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Email : ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: _width / 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        email,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Phone : ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: _width / 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        phone,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Position : ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: _width / 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        position,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Branch : ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: _width / 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        branch,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Address : ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: _width / 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        address,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
            ))
      ],
    );
  }
}
